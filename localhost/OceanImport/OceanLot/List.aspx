<%@ Page Language="C#" AutoEventWireup="true" CodeFile="List.aspx.cs" ValidateRequest="false"
    Inherits="OceanImport_OceanLot_List" %>

<%@ Register Src="../../common/UIControls/UserSheet.ascx" TagName="UserSheet" TagPrefix="uc2" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<%@ Register Src="../../common/UIControls/UserComboBox.ascx" TagName="UserComboBox"
    TagPrefix="uc1" %>
<%@ Register Src="../../common/UIControls/UserControlTop.ascx" TagName="UserControlTop"
    TagPrefix="uc1" %>
<%@ Register Src="../../common/UIControls/AutoComplete.ascx" TagName="AutoComplete"
    TagPrefix="uc1" %>
  <%@ Register src="/common/UIControls/Costing.ascx" tagname="Costing" tagprefix="uc1" %>  
  <%@ Register Src="../../common/UIControls/Transfer.ascx" TagName="Transfer"
    TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Master</title>

    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>

    <link href="../../css/style.css" rel="stylesheet" type="text/css" /> 

    <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>

    <script src="../../common/ylQuery/Grid.js" type="text/javascript"></script>

    <script src="../AjaxServer/gridList.js" type="text/javascript"></script>

    <script src="../../common/UIControls/CompanyDrpList.js" type="text/javascript"></script>
    
    <script src="../../OceanImport/AjaxServer/Valid.js" type="text/javascript"></script>
    <script type="text/javascript">

        var PPCC = function(value) {
            var r = StorePPCC.getById(value);

            if (Ext.isEmpty(r)) {
                return "";
            }
            return r.data.text;
        };

        var StoreCompany = function(value) {
            var r = StoreCmb.getById(value);

            if (Ext.isEmpty(r)) {
                return "";
            }
            return r.data.text;
        };

        var StoreDescription = function(value) {
            var r = StoreItem.getById(value);

            if (Ext.isEmpty(r)) {
                return "";
            }
            return r.data.text;
        };

        var ToUpper = function(value) {
            return value.toUpperCase();
        }
        
    </script>
    <style type="text/css">
        table .x-form-field-wrap .x-form-trigger
        {
           margin-top:0px !important;  
        }
    </style>
   
</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager runat="server" GZip="true" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
    <div id="div_title" style="width: 100%; z-index:1000">
        <uc1:UserControlTop ID="UserControlTop1" runat="server" sys="O" />
    </div>
    
     
     
    <div id="div_title" style="margin-left: 10px; margin-top: 80px; z-index:990">
        <table width="980px" border="0" cellspacing="0" cellpadding="0" class="table_nav1 font_11bold_1542af">
                <tr>
                    <td style="padding-left: 5px;">
                    <table><tr><td>
                     <img src="/images/arrows_btn.png" id="img_showlist" style="cursor: pointer; vertical-align: middle"
                                    alt="View" onclick="createFrom('OI');" />
                     &nbsp; 
                        OI - Lot (Master) Information &nbsp;
                        <img src="../../images/void.png" runat="server" id="img_void" style="vertical-align: middle;" />
                    </td></tr></table>
                   
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
                        <nobr>
                        <%if (!string.IsNullOrEmpty(Request["seed"])) { Response.Write("Lot#"); }%> </nobr>
                    </td>
                    <td style="padding-left: 5px;">
                        <ext:Label runat="server" ID="labImpLotNo" StyleSpec=" color:#ff0000">
                        </ext:Label>
                        <ext:Hidden ID="hidLotNo" runat="server">
                        </ext:Hidden>
                    </td>
                        <td>
                 <%if (!string.IsNullOrEmpty(Request["seed"]))
                 { %>
                  <uc1:Transfer runat="server" ID="TransferSys" sys="OI" type="M"/>
                   <%} %>
                  </td>     </tr>
                            </table>
                    </td>
                    
                </tr>
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
            <ext:JsonReader  IDProperty="value">
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
    <ext:Store runat="server" ID="StoreServiceMode" OnRefreshData="StoreMode_OnRefreshData">
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
     <ext:Hidden ID="hidVoid" runat="server" Text="0">
    </ext:Hidden>
    <div style="margin-bottom: 20px; margin-top: 111px; margin-left: 10px">
        <table width="969" border="0" cellspacing="0" cellpadding="0">
            <tbody>
                <tr>
                    <td width="665px" valign="top">
                        <table width="665px" border="0" cellpadding="0" cellspacing="4">
                            <tbody>
                              <tr>
                                    <td width="58" align="left" style="padding-left: 2px" class="font_11bold">
                                        Coloader MBL#
                                    </td>
                                    <td width="84" align="left" class="font_11px_gray">
                                        <ext:TextField ID="txtColoader" runat="server" Cls="text" Width="90" TabIndex="1">
                                        </ext:TextField>
                                    </td>
                                    <td width="80" align="left" class="font_11bold" style="padding-left:3px">
                                        Reference#
                                    </td>
                                    <td align="left">
                                        <span class="font_11px_gray">
                                            <ext:TextField ID="txtReference" runat="server" Cls="text" Width="86" TabIndex="2">
                                            </ext:TextField>
                                        </span>
                                    </td>
                                    <td align="left" class="font_11bold" style="padding-left:2px">
                                        Clearance#
                                    </td>
                                    <td  align="left">
                                        <span class="font_11px_gray">
                                            <ext:TextField ID="txtClearance" runat="server" Cls="text" Width="85" TabIndex="3">
                                            </ext:TextField>
                                        </span>
                                    </td>
                                    <td align="left">
                                        OE Lot#
                                    </td>
                                    <td class="font_11px_gray" style="padding-right:2px">
                                       
                                            <ext:TextField ID="txtOELot" runat="server" Width="94" Cls="text_80px" TabIndex="4">
                                            </ext:TextField>
                                     
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    <table width="68px"><tr><td>MBL#</td><td  class="font_red" align="right">*</td></tr></table>
                                    </td>
                                    <td align="left">
                                        <ext:TextField ID="txtMBL" runat="server" Cls="text" Width="90"  TabIndex="5" EnableKeyEvents="true">
                                        <Listeners>
                                                    <Blur Handler="validName(this.id,'MBL',#{hidSeed}.getValue());" />
                                                </Listeners>
                                        </ext:TextField>
                                    </td>
                                   <td style="padding-left:3px"><table cellpadding="0" cellspacing="0" border="0" width="82px"><tr>
                                    <td align="left" class="font_11bold">
                                        Service Mode<span class="font_red" style="padding-left:2px">*</span>
                                    </td>
                                   </tr></table></td>
                                    <td  align="left">
                                        <table  border="0" cellpadding="0" cellspacing="0" >
                                            <tbody>
                                                <tr>
                                                    <td>
                                                        <uc1:UserComboBox runat="server" ID="cmbMode" ListWidth="180" Query="option=ServerMode"
                                                            StoreID="StoreServiceMode" Width="65" winTitle="Service Mode" winUrl="/BasicData/ServiceMode/ServiceMode.aspx?sys=O"
                                                            winWidth="516" winHeight="585" TabIndex="6"  clsClass="select"/>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                    <td>
                                    <table width="70px"><tr><td>PPD/COL</td><td class="font_red" align="right">*</td></tr></table>
                                    </td>
                                    <td align="left">
                                        <table  border="0" cellpadding="0" cellspacing="0">
                                            <tbody>
                                                <tr>
                                                    <td>
                                                        <ext:ComboBox ID="cmbPPD" runat="server" Cls="select" Width="85" StoreID="StorePPCC" TabIndex="7"
                                                            DisplayField="text"  ValueField="text" Mode="Local" ForceSelection="true"
                                                            TriggerAction="All">
                                                        </ext:ComboBox>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                    <td align="left">
                                        Salesman
                                    </td>
                                    <td  align="left" valign="top">
                                        <table width="100" border="0" cellpadding="0" cellspacing="0">
                                            <tbody>
                                                <tr>
                                                    <td>
                                                        <uc1:UserComboBox runat="server" ID="cmbSales" Query="option=SalesList"
                                                            Width="75" clsClass="select" StoreID="StoreSalesman" winTitle="Salesman" winUrl="/BasicData/Salesman/list.aspx" TabIndex="8"
                                                            winWidth="680" winHeight="560" />
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    <table width="68px"><tr><td>Carrier</td><td class="font_red" align="right">*</td></tr></table>
                                    </td>
                                    <td colspan="3" align="left" valign="top">
                                        <table width="261" border="0" cellpadding="0" cellspacing="0">
                                            <tbody>
                                                <tr>
                                                   <Td><table cellpadding="0" cellspacing="0" border="0" width="270"><tr>
                                                    <td width="85">
                                                        <%-- <uc1:UserComboBox runat="server" ID="cmbCarrierCode" TabIndex="9" clsClass="select"
                                                            Query="option=CompanyList" StoreID="StoreCmb1" Width="85" winTitle="Company"
                                                            winUrl="/BasicData/Customer/detail.aspx" winWidth="800" winHeight="800" />--%>
                                                        <uc1:AutoComplete runat="server" ID="cmbCarrierCode" TabIndex="9" clsClass="text input"
                                                            Query="option=CompanyList" Width="63" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                            winWidth="800" winHeight="800" />
                                                    </td>
                                                   </tr></table></Td>
                                                    <td style="padding-left: 2px">
                                                    </td>
                                                    <td width="170">
                                                    </td>
                                                    <td width="22">
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                    
                                    <td align="left" valign="middle" class="font_11bold" style="padding-left:2px">
                                        Manifest To
                                    </td>
                                    <td colspan="3">
                                       
                                        <uc1:AutoComplete runat="server" ID="txtM_to" TabIndex="15" clsClass="x-form-text x-form-field text"
                                            Query="option=CompanyList" Width="58" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                            winWidth="800" winHeight="800" />
                                    </td>
                                    <td align="left"  style="display:none">
                                        <table width="50" border="0" cellpadding="0" cellspacing="0">
                                            <tbody>
                                                <tr>
                                                    <td width="10">
                                                        <ext:Checkbox ID="chbDirect" runat="server" Width="25" FieldLabel="" TabIndex="10">
                                                        </ext:Checkbox>
                                                    </td>
                                                    <td width="50" class="font_11bold">
                                                        Direct
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td><table width="68"><tr><td>Shipper</td><td class="font_red" align="right">*</td></tr></table>
                                    </td>
                                    <td colspan="3" align="left" valign="top" style="padding-top: 4px">
                                        <table width="261" border="0" cellpadding="0" cellspacing="0">
                                            <tbody>
                                                <tr>
                                                   <td><table cellpadding="0" cellspacing="0" border="0" width="270"><tr>
                                                    <td width="85">
                                                        <%-- <uc1:UserComboBox runat="server" ID="cmbShipperCode" TabIndex="11" clsClass="select"
                                                            Query="option=CompanyList" StoreID="StoreCmb1" Width="85" winTitle="Company"
                                                            winUrl="/BasicData/Customer/detail.aspx" winWidth="800" winHeight="800" />--%>
                                                        <uc1:AutoComplete runat="server" ID="cmbShipperCode" TabIndex="11" clsClass="x-form-text x-form-field text"
                                                            Query="option=CompanyList" Width="63" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                            winWidth="800" winHeight="800" />
                                                    </td>
                                                   </tr></table></td>
                                                    <td style="padding-left: 2px">
                                                    </td>
                                                    <td width="170">
                                                    </td>
                                                    <td width="22">
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                    <td>
                                    <table width="70px"><tr><td>Vessel/<br />Voyage</td><td class="font_red" align="right" valign="middle">*</td></tr></table>
                                    </td>
                                    <td colspan="3" valign="top" style="padding-top: 4px">
                                        <table cellpadding="0" cellspacing="0" border="0">
                                            
                                                <tr>
                                                    <td>
                                                        <ext:ComboBox ID="cmbVesselCode" runat="server" Cls="select" Width="130" StoreID="StoreVessel"
                                                            DisplayField="text" TabIndex="15" ValueField="value" Mode="Local" ForceSelection="true"
                                                            TriggerAction="All">
                                                            <Listeners>
                                                                <Select Handler="getVessel(this.getValue(),this.getText())" />
                                                            </Listeners>
                                                            <DirectEvents>
                                                                <Select OnEvent="cmbVessel_Select">
                                                                    <EventMask CustomTarget="cmbVesselText" />
                                                                </Select>
                                                            </DirectEvents>
                                                        </ext:ComboBox>
                                                    </td>
                                                  
                                                    <td style="padding-left:3px">
                                                        <ext:ComboBox ID="cmbVesselText" runat="server" Cls="select" Width="89" StoreID="StoreVoyage"  ItemSelector="tr.list-item" ListWidth="130px"
                                                            DisplayField="text" ValueField="value" Mode="Local" ForceSelection="true" TriggerAction="All">
                                                            <Listeners>
                                                                <Select Handler="CompanyX.BindVoyag(this.getValue());" />
                                                            </Listeners>
                                                        </ext:ComboBox>
                                                    </td>
                                                    <td>
                                                       <img src="../../images/select_btn.jpg" width="18" height="18" class="cursor" alt=""
                                                           onclick="CompanyX.ShowVoyage();">
                                                    </td>
                                                </tr>
                                            
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    <table width="68px"><tr><td>Consignee</td><td class="font_red" align="right">*</td></tr></table>
                                    </td>
                                    <td colspan="3" align="left" valign="top">
                                        <table width="261" border="0" cellpadding="0" cellspacing="0">
                                            <tbody>
                                                <tr>
                                                  <td><table cellpadding="0" cellspacing="0" border="0" width="270"><tr>
                                                    <td width="85">
                                                        <%-- <uc1:UserComboBox runat="server" ID="cmbConsigneeCode" TabIndex="12" clsClass="select"
                                                            Query="option=CompanyList" StoreID="StoreCmb1" Width="85" winTitle="Company"
                                                            winUrl="/BasicData/Customer/detail.aspx" winWidth="800" winHeight="800" /> --%>
                                                        <uc1:AutoComplete runat="server" ID="cmbConsigneeCode" TabIndex="12" clsClass="x-form-text x-form-field text"
                                                            Query="option=CompanyList" Width="63" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                            winWidth="800" winHeight="800" />
                                                    </td>
                                                  </tr></table></td>
                                                    <td style="padding-left: 2px">
                                                    </td>
                                                    <td width="170">
                                                    </td>
                                                    <td width="22">
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                    <td align="left" valign="middle" class="font_11bold">
                                    <table width="70px"><tr><td>Loading</td><td class="font_red" align="right">*</td></tr></table>
                                    </td>
                                    <td align="left" valign="middle">
                                        <table  border="0" cellpadding="0" cellspacing="0">
                                            <tbody>
                                                <tr>
                                                    <td >
                                                        <uc1:UserComboBox runat="server" ID="cmbLoading" ListWidth="180" clsClass="select_160px"
                                                            TabIndex="16" Query="option=LocationList&sys=O" StoreID="StoreLocation" Width="64"
                                                            winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=O" winWidth="845"
                                                            winHeight="620" />
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                    <td align="left" valign="middle">
                                        ETD<span class="font_red" style="padding-left:5px">*</span>
                                    </td>
                                    <td align="left" valign="middle" class="font_11px_gray">
                                       
                                            <ext:DateField ID="txtETD" runat="server" Width="94" Cls="text_100px" Format="d/m/Y"
                                                TabIndex="19">
                                            </ext:DateField>
                                       
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="middle" class="font_11bold" style="padding-left: 2px; padding-bottom: 2px">
                                        Co-Loader
                                    </td>
                                    <td colspan="3" align="left" valign="top" style="padding-top: 3px">
                                        <table width="261" border="0" cellpadding="0" cellspacing="0">
                                            <tbody>
                                                <tr>
                                                   <td><table cellpadding="0" cellspacing="0" border="0" width="270"><tr>
                                                    <td width="85">
                                                        <%-- <uc1:UserComboBox runat="server" ID="cmbDischargeCode" TabIndex="13" clsClass="select"
                                                            Query="option=CompanyList" StoreID="StoreCmb1" Width="85" winTitle="Company"
                                                            winUrl="/BasicData/Customer/detail.aspx" winWidth="800" winHeight="800" />--%>
                                                        <uc1:AutoComplete runat="server" ID="cmbDischargeCode" TabIndex="13" clsClass="x-form-text x-form-field text"
                                                            Query="option=CompanyList" Width="63" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                            winWidth="800" winHeight="800" />
                                                    </td>
                                                   </tr></table></td>
                                                    <td style="padding-left: 2px">
                                                    </td>
                                                    <td width="170">
                                                    </td>
                                                    <td width="22">
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                    <td><table width="70px"><tr><td>Discharge<br /> Port</td><td class="font_red" align="right" valign="middle">*</td></tr></table></td>
                                    <td align="left" valign="middle">
                                        <table  border="0" cellpadding="0" cellspacing="0">
                                            <tbody>
                                                <tr>
                                                    <td >
                                                        <uc1:UserComboBox runat="server" ID="cmbPort" ListWidth="180" clsClass="select_160px"
                                                            TabIndex="17" Query="option=LocationList&sys=O" StoreID="StoreLocation" Width="64"
                                                            winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=O" winWidth="845"
                                                            winHeight="620" />
                                                    </td>
                                                    
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                    <td align="left" valign="middle">
                                        ETA <span class="font_red" style="padding-left:2px">*</span><br />Discharge
                                    </td>
                                    <td align="left" valign="middle"  class="font_11px_gray">
                                        
                                            <ext:DateField ID="txtETADischarge" runat="server" Width="94" Format="d/m/Y" Cls="text_100px"
                                                TabIndex="20">
                                            </ext:DateField>
                                     
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="middle" class="font_11bold" style="padding-left: 2px">
                                        Broker
                                    </td>
                                    <td colspan="3" align="left" valign="top">
                                        <table width="261" border="0" cellpadding="0" cellspacing="0">
                                            <tbody>
                                                <tr>
                                                    <td><table cellpadding="0" cellspacing="0" border="0" width="270"><tr>
                                                    <td width="85">
                                                        <%-- <uc1:UserComboBox runat="server" ID="cmbBrokerCode" TabIndex="14" clsClass="select"
                                                            Query="option=CompanyList" StoreID="StoreCmb1" Width="85" winTitle="Company"
                                                            winUrl="/BasicData/Customer/detail.aspx" winWidth="800" winHeight="800" /> --%>
                                                        <uc1:AutoComplete runat="server" ID="cmbBrokerCode" TabIndex="14" clsClass="x-form-text x-form-field text"
                                                            Query="option=CompanyList" Width="63" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                            winWidth="800" winHeight="800" />
                                                    </td>
                                                    </tr></table></td>
                                                    <td style="padding-left: 2px">
                                                    </td>
                                                    <td width="170">
                                                    </td>
                                                    <td width="22">
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                   <td><table width="70px"><tr><td>Final Dest</td><td class="font_red" align="right">*</td></tr></table>
                                    </td>
                                    <td align="left" valign="middle">
                                        <table border="0" cellpadding="0" cellspacing="0">
                                            <tbody>
                                                <tr>
                                                    <td>
                                                        <uc1:UserComboBox runat="server" ID="cmbFinalDest" ListWidth="180" clsClass="select_160px"
                                                            TabIndex="18" Query="option=LocationList&sys=O" StoreID="StoreLocation" Width="64"
                                                            winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=O" winWidth="845"
                                                            winHeight="620" />
                                                    </td>
                                                 
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                    <td align="left" valign="middle">
                                        ETA Final
                                    </td>
                                    <td align="left" valign="middle"  class="font_11px_gray">
                                        
                                            <ext:DateField ID="txtETAFinal" runat="server" Width="94" Format="d/m/Y" Cls="text_100px"
                                                TabIndex="21">
                                            </ext:DateField>
                                      
                                    </td>
                                </tr>     
                               <%-- <tr><td align="left" valign="middle" class="font_11bold" style="padding-left: 2px;">
                                        Remark
                                    </td>
                                    <td colspan="8" style=" padding-top: 3px"><ext:TextArea runat="server"  Cls="text_100px" ID="txtMAWBRemark" Height="45" Width="272" TabIndex="21"></ext:TextArea></td>
                                    </tr>--%>
                                 <tr>
                                     <td colspan="8">
                                     <table border="0" cellpadding="0" cellspacing="0">
                                         <tr>
                                        <td  width="68" class="font_11bold" style="padding-left: 2px; vertical-align: top; padding-top: 6px;">Account Remark
                                        </td>
                                        <td colspan="3" style="vertical-align: top; padding-top: 3px;width:278px;">
                                            <ext:TextArea ID="txtAccRemark" runat="server" Width="270" Height="46" Cls="text_100px"
                                                TabIndex="16">
                                            </ext:TextArea>
                                        </td>
                                        <td   width="71" class="font_11bold" style="padding-left: 2px; vertical-align: top; padding-top: 6px;">Shipping Remark
                                        </td>
                                        <td colspan="3" style="vertical-align: top; padding-top: 3px;">
                                            <ext:TextArea ID="txtMAWBRemark" runat="server"  Width="243" Height="46" Cls="text_100px"
                                                TabIndex="16">
                                            </ext:TextArea>
                                        </td>
                                             </tr>
                                     </table>
                                         </td>
                                    </tr>
                            </tbody>
                        </table>
                    </td>
                    <td width="455" valign="top" style="padding-left: 3px">
                        <div id="div_top" style="margin-top: 115px;">
                            <table width="301" border="0" cellpadding="0" cellspacing="0" class="table_nav2">
                                <tbody>
                                    <tr>
                                        <td width="301" class="font_11bold_1542af" style="padding-left: 5px;">
                                            Action
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <table width="260" height="40" border="0" align="center" cellpadding="0" cellspacing="0">
                                <tbody>
                                    <tr>
                                        <td width="88" class="table" style="padding-bottom: 5px; padding-top: 5px">
                                            <table border="0" cellspacing="0" cellpadding="0">
                                                <tbody>
                                                    <tr>
                                                        <td align="Center">
                                                            <ext:Button ID="btnNext" runat="server" Cls="Submit_65px" Text=" Next " Width="70px">
                                                                <DirectEvents>
                                                                    <Click OnEvent="btnNext_Click">
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
                                        <td width="76" class="table">
                                            <table border="0" cellspacing="0" cellpadding="0">
                                                <tbody>
                                                    <tr>
                                                        <td align="center" style="padding-left: 2px">
                                                            <ext:Button ID="btnVoid" runat="server" Cls="Submit_65px" Text=" Void " Width="70px">
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
                        <table cellpadding="0" cellspacing="0" border="0" style="margin-top: 75px" width="299">
                            <tr>
                                <td>
                                    <table width="" border="0" cellspacing="4" cellpadding="0">
                                        <tbody>
                                            <tr>
                                            </tr>
                                            <tr>
                                                <td >
                                                    <table cellpadding="0" cellspacing="0" border="0"style="padding-left:17px; padding-right:1px">
                                                        <tr>
                                                            <td>
                                                                ATD<span class="font_red" style="padding-left:8px" >*</span>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td style="width:90px">
                                                    <span class="font_11px_gray">
                                                        <ext:DateField ID="txtATD" runat="server" Width="90" Cls="text_80px" Format="d/m/Y"
                                                            TabIndex="22">
                                                        </ext:DateField>
                                                    </span>
                                                </td>
                                                <td>
                                                    <table cellpadding="0" cellspacing="0" border="0"  style="padding-left: 11px; width:45px">
                                                        <tr>
                                                            <td>
                                                                ATA
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td valign="left" style="width:90px">
                                                    <ext:DateField ID="txtATA" runat="server" Width="90" Cls="text_80px" Format="d/m/Y"
                                                        TabIndex="23">
                                                    </ext:DateField>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="4" height="2">
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                  <table border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                <table bgcolor="8db2e3" border="0" cellpadding="0" cellspacing="1" height="25" width="303px">
                                    <tr>
                                        <td align="left" background="../../../images/bg_line_3.jpg" bgcolor="#FFFFFF" class="font_11bold_1542af"
                                            style="padding-left: 5px">
                                            Storage Information
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td height="5">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table width="250" border="0" cellpadding="0" cellspacing="4" class="select_142px">
                                    <tbody>
                                        <tr valign="top">
                                            <td width="62" height="0" class="font_11bold" style="padding-left: 2px; padding-top:3px">
                                                WHSE
                                            </td>
                                         <td><table cellpadding="0" cellspacing="0" border="0" width="220px"><tr>
                                         <td width="87" height="0">
                                                <%-- <uc1:UserComboBox runat="server" ID="cmbWarehouse" TabIndex="30" clsClass="select_160px"
                                                    StoreID="StoreCmb3" Width="156" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                    winWidth="800" winHeight="800" Query="option=CompanyList" /> --%>
                                                <uc1:AutoComplete runat="server" ID="cmbWarehouse" TabIndex="23" clsClass="x-form-text x-form-field text"
                                                    Width="63" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx" winWidth="800" isAlign="false"
                                                    winHeight="800" Query="option=CompanyList" />
                                            </td>
                                         </tr></table></td>
                                        </tr>
                                        <tr>
                                            <td >
                                                <table width="68px" border="0" cellpadding="0" cellspacing="0">
                                                    <tbody>
                                                        <tr>
                                                            <td class="font_11bold" style="padding-left: 2px">
                                                                Free Storage
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                            <td height="0">
                                                <table width="129" border="0" cellspacing="0" cellpadding="0">
                                                    <tbody>
                                                        <tr>
                                                            <td width="60">
                                                                <ext:DateField ID="txtFreeStorageStart" runat="server" Format="d/m/Y" Cls="text_60px"
                                                                    Width="90" TabIndex="23">
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
                                                                <ext:DateField ID="txtFreeStorageEnd" runat="server" Cls="text_60px" Format="d/m/Y" TabIndex="23"
                                                                    Width="90">
                                                                </ext:DateField>
                                                            </td>
                                                            <td width="10">
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td height="0" class="font_11bold" style="padding-left: 2px">
                                                Pickup
                                            </td>
                                            <td height="0">
                                                <ext:DateField ID="txtPickup" runat="server" Format="d/m/Y" Cls="text_60px" Width="90"
                                                    TabIndex="23">
                                                </ext:DateField>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </tbody>
        </table>
        <table cellpadding="0" cellspacing="0" border="0" width="969">
            <tr>
                <td colspan="2" height="5">
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <table width="670px" height="25" border="0" cellpadding="0" cellspacing="0" bgcolor="8db2e3"
                        style="border-left: 1px solid #8db2e3; border-right: 1px solid #8db2e3; border-top: 1px solid #8db2e3;">
                        <tbody>
                            <tr>
                                <td width="670px" align="left" valign="top" bgcolor="#FFFFFF" background="../../../images/bg_line_3.jpg">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tbody>
                                            <tr>
                                                <td width="48%" align="left" class="font_11bold_1542af" style="padding-left: 5px;height:25px;">
                                                    HBL List
                                                </td>
                                                <td width="52%" align="right"  class="nav_menu_4" style="padding-right:3px;">
                                                      <div id="showHBL">
                                                    <script type="text/javascript">
                                                        if (Request("seed") != "") {
                                                            document.write("<a href='javascript:Add()'>New</a>");
                                                        }                                                  
                                                    </script></div>

                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td>
                <td valign="top" align="left" style="padding-left: 5px" rowspan="3">
                    
                    <table bgcolor="8db2e3" border="0" cellpadding="0" cellspacing="1" height="25" width="303px">
                                    <tr><td align="left" background="../../../images/bg_line_3.jpg" bgcolor="#FFFFFF" class="font_11bold_1542af" style="padding-left: 5px"></td></tr></table>
                                    <table width="200" border="0" cellpadding="0" cellspacing="0"  class="table_23_left"  style="padding-top:5px">
                             
                                        <tr valign="bottom"><td></td><td class="font_11bold" align="center">Actual</td><td class="font_11bold"  align="center">Charge</td><td></td></tr>
                                            <tr>
                                              <td bgcolor="#FFFFFF" class="font_11bold" style="padding-left:5px; padding-right:1px" align="left">
                                                     Piece(s)<%--<span class="font_red" style="padding-left:2px">*</span>--%>
                                                </td>
                                                 <td bgcolor="#FFFFFF" align="left">
                                                    <ext:NumberField ID="txtAPiece" runat="server" Width="70" DecimalPrecision="0"  StyleSpec="text-align:right"
                                                    Cls="select_160px"  Disabled="true">
                                                    </ext:NumberField>
                                                </td>
                                                <td align="left" bgcolor="#FFFFFF"  style="padding-left:3px; padding-right:3px; width:92px">
                                                    <ext:NumberField ID="txtPiece" runat="server" Cls="text_70px" Width="70"  DecimalPrecision="0" StyleSpec="text-align:right"
                                                        TabIndex="24">
                                                    </ext:NumberField>
                                                </td>
                                                <td align="left" bgcolor="#FFFFFF" >
                                                   <table cellpadding="0" cellspacing="0" border="0"><tr><td>
                                                    <uc1:UserComboBox runat="server" ID="CmbUnit" ListWidth="180" clsClass="select_160px" StyleSpec="text-align:right"
                                                        TabIndex="25" Query="option=UnitBinding" StoreID="StoreUnit" Width="50" winTitle="Unit"  isButton="false"
                                                        winUrl="/BasicData/Unit/list.aspx" winWidth="510" winHeight="585" />
                                                   </td></tr></table>
                                                </td>
                                        
                                                
                                          
                                            </tr>
                                            <tr>
                                              <td align="left" bgcolor="#FFFFFF" class="font_11bold" style="padding-left:5px; padding-right:10px">
                                                  WT
                                                </td>
                                                  <td  align="left">
                                                    <ext:NumberField ID="txtAGWT" runat="server" Width="70"   StyleSpec="text-align:right" DecimalPrecision="3"
                                                    Cls="select_160px"  Disabled="true">
                                                    </ext:NumberField>
                                                 </td>
                                                <td align="left" bgcolor="#FFFFFF" style="padding-left:3px; padding-right:3px">
                                                    <ext:NumberField ID="txtGWT" runat="server"   Cls="text_80px" Width="70" TabIndex="26" StyleSpec="text-align:right"  DecimalPrecision="3">
                                                       <Listeners>
                                                         <Blur Handler="var wt=#{txtGWT}.getValue()!=''?#{txtGWT}.getValue():#{txtAGWT}.getValue();var cbm=#{txtCBM}.getValue()!=''?#{txtCBM}.getValue():#{txtACBM}.getValue(); if(wt!=''){ if(cbm==''){#{txtCWT}.setValue(wt*1.0000/1000)} else{if(wt>cbm*1000){#{txtCWT}.setValue(wt*1.0000/1000)}else{#{txtCWT}.setValue(cbm)}} } else { if(cbm!=''){#{txtCWT}.setValue(cbm)}}"  />
                                                     </Listeners>
                                                    </ext:NumberField>
                                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                        <tbody>
                                                            <tr>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>

                                            </tr>
                                            <tr> <td align="left" bgcolor="#FFFFFF" class="font_11bold"  style="padding-left:5px">
                                                    CBM
                                                </td>
                                                <td align="left">
                                                <ext:NumberField ID="txtACBM" runat="server" Width="70"   StyleSpec="text-align:right" DecimalPrecision="3"
                                                Cls="select_160px" Disabled="true">
                                                </ext:NumberField>
                                                </td>
                                                <td align="left" bgcolor="#FFFFFF" style="padding-left:3px">
                                                    <ext:NumberField ID="txtCBM" runat="server" Cls="text_80px" Width="70" DecimalPrecision="3" StyleSpec="text-align:right" 
                                                        TabIndex="27">
                                                        <Listeners>
                                                         <Change Handler="var wt=#{txtGWT}.getValue()!=''?#{txtGWT}.getValue():#{txtAGWT}.getValue();var cbm=#{txtCBM}.getValue()!=''?#{txtCBM}.getValue():#{txtACBM}.getValue(); if(cbm!=''){if(wt==''){#{txtCWT}.setValue(cbm)}else{ if(wt>cbm*1000){#{txtCWT}.setValue(wt*1.0000/1000)}else{#{txtCWT}.setValue(cbm)} }} else{ if(wt!=''){#{txtCWT}.setValue(wt*1.0000/1000)}};#{txtCWT}.focus(true);" />
                                                      </Listeners>
                                                    </ext:NumberField>
                                                </td></tr>
                                            <tr>
                                          
                                                <td align="left" bgcolor="#FFFFFF" class="font_11bold"  style="padding-left:5px">
                                                    WM </td>
                                                    <td align="left">
                                                    <ext:NumberField ID="txtAWM" runat="server" Width="70"   StyleSpec="text-align:right" DecimalPrecision="3"
                                                    Cls="select_160px" Disabled="true">
                                                    </ext:NumberField>
                                                    </td>
                                                <td align="left" bgcolor="#FFFFFF" style="padding-left:3px; padding-right:3px">
                                                    <ext:NumberField ID="txtCWT" runat="server" Cls="text_70px" Width="70" StyleSpec="text-align:right" DecimalPrecision="3" TabIndex="28">
                                                    </ext:NumberField>
                                                </td>
                                                
                                            </tr>
                                            <tr>
                                            <td align="left" style="padding-left:5px" bgcolor="#FFFFFF" >
                                            <table cellpadding="0" cellspacing="0" border="0" width="71px"><tr><td  class="font_11bold">Container</td></tr></table></td>
                                                <td align="left" bgcolor="#FFFFFF" colspan="3">
                                                    <ext:NumberField ID="txtContainer" runat="server" Cls="text_70px" Width="70" Disabled="true" StyleSpec="text-align:right"
                                                        AllowDecimals="false" >
                                                    </ext:NumberField>
                                                </td></tr>
                                  
                                    </table>
                </td>
            </tr>
            <tr>
                <td valign="top" id="GridView_1">
                    <ext:GridPanel runat="server" ID="gridHBL" TrackMouseOver="true" Width="670px" Height="150">
                        <LoadMask ShowMask="true" Msg=" Loading ... " />
                        <Store>
                            <ext:Store runat="server" ID="storeHBL">
                                <Reader>
                                    <ext:JsonReader>
                                        <Fields>
                                            <ext:RecordField Name="RowID">
                                            </ext:RecordField>
                                            <ext:RecordField Name="HBL" Type="String">
                                            </ext:RecordField>
                                            <ext:RecordField Name="Consignee">
                                            </ext:RecordField>
                                            <ext:RecordField Name="Final">
                                            </ext:RecordField>
                                            <ext:RecordField Name="ServiceMode">
                                            </ext:RecordField>
                                            <ext:RecordField Name="CWT">
                                            </ext:RecordField>
                                            <ext:RecordField Name="CBM">
                                            </ext:RecordField>
                                            <ext:RecordField Name="PKGS">
                                            </ext:RecordField>
                                            <ext:RecordField Name="WM">
                                            </ext:RecordField>
                                            <ext:RecordField Name="PPD">
                                            </ext:RecordField>
                                        </Fields>
                                    </ext:JsonReader>
                                </Reader>
                            </ext:Store>
                        </Store>
                        <ColumnModel runat="server" ID="ctl1762">
                            <Columns>
                                <ext:RowNumbererColumn Header="No." Width="30">
                                </ext:RowNumbererColumn>
                                <ext:Column Header="HBL" DataIndex="HBL" Width="100">
                                </ext:Column>
                                <ext:Column Header="Consignee" DataIndex="Consignee" Width="125">
                                </ext:Column>
                                <ext:Column Header="Final" DataIndex="Final" Width="50" Align="Center">
                                </ext:Column>
                                <ext:Column Header="Service Mode" DataIndex="ServiceMode" Width="85">
                                </ext:Column>
                                <ext:NumberColumn Header="WT" DataIndex="CWT" Width="60" Format="0.000" Align="Right">
                                </ext:NumberColumn>
                                <ext:NumberColumn Header="CBM" DataIndex="CBM" Width="60" Format="0.000" Align="Right">
                                </ext:NumberColumn>
                                <ext:NumberColumn Header="Piece(s)" DataIndex="PKGS" Width="70" Align="Right" Format="0">
                                </ext:NumberColumn>
                                <ext:Column Header="PPD/COL" DataIndex="PPD" Width="70" Align="Center">
                                </ext:Column>
                                <ext:NumberColumn Header="RowID" DataIndex="RowID" Hidden="true" Width="0">
                                
                                </ext:NumberColumn>
                               
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
                <td height="5">
                </td>
                <td valign="top" align="left" style="padding-left: 5px">
                </td>
            </tr>
            <tr>
                <td valign="top" id="GridView_2">
                    <ext:GridPanel runat="server" ID="gridInvoice" TrackMouseOver="true" Width="670px"
                        Height="170" Title="Local Invoice" Footer="true" Header="true">
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
                                <ext:Column Header="DN/CN No." DataIndex="DN_CNNO" Width="120">
                                </ext:Column>
                                <ext:Column Header="Code" DataIndex="CompanyName" Width="120">
                                </ext:Column>
                                <ext:Column Header="CUR" DataIndex="Currency" Width="40" Align="Center">
                                </ext:Column>
                                <ext:NumberColumn Header="Amount" DataIndex="Amount" Width="80" Align="Right" Format="0.00">
                                </ext:NumberColumn>
                                <ext:NumberColumn Header="RowID" DataIndex="RowID" Hidden="true" >
                                </ext:NumberColumn>
                                <ext:CheckColumn Header="Print" Width="40" DataIndex="Print" Align="Center">
                                </ext:CheckColumn>
                                <ext:CheckColumn Header="Void" Width="40" DataIndex="Void" Align="Center">
                                </ext:CheckColumn>
                                <ext:CheckColumn Header="AC" Width="40" DataIndex="AC" Align="Center">
                                </ext:CheckColumn>
                               
                            </Columns>
                        </ColumnModel>
                      
                        <SelectionModel>
                            <ext:RowSelectionModel ID="RowSelectionModel2" runat="server">
                            </ext:RowSelectionModel>
                        </SelectionModel>
                       
                    </ext:GridPanel>
                </td>
                <td id="dis_Invoice" valign="top" style="padding-left: 5px; display:block">
                    <uc2:UserSheet ID="UserSheet1" runat="server" disHeader="false" isLoad="true" Height="118" />
                </td>
            </tr>
            <tr>
                <td height="5" colspan="2">
                </td>
            </tr>
            <tr>
              <td colspan="2">
              <uc1:Costing ID="ucCost"  runat="server" type="M"  sys="OI"/>
              </td>
            </tr>
            <tr>
                <td class="style2">
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
