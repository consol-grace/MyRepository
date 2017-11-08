<%@ Page Language="C#" AutoEventWireup="true" CodeFile="List.aspx.cs" Inherits="AirExport_AESubShipment_List" %>
<%@ Register src="/common/UIControls/Costing.ascx" tagname="Costing" tagprefix="uc1" %>
<%@ Register Src="../../common/UIControls/UserControlTop.ascx" TagName="UserControlTop"
    TagPrefix="uc1" %>
<%@ Register Src="../../common/UIControls/UserSheet.ascx" TagName="UserSheet" TagPrefix="uc2" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<%@ Register Src="../../common/UIControls/UserComboBox.ascx" TagName="UserComboBox"
    TagPrefix="uc1" %>
<%@ Register Src="../../common/UIControls/AutoComplete.ascx" TagName="AutoComplete"
    TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>AE Sub Shipment</title>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />

    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>

    <script src="../../common/ylQuery/Grid.js" type="text/javascript"></script>

    <script src="../../common/UIControls/CompanyDrpList.js" type="text/javascript"></script>

    <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>

    <script src="../../AirExport/AEValid/Valid.js" type="text/javascript"></script>
 
    <script type="text/javascript">

     var afterEdit = function(e) {
        CompanyX.UpdateHawb(e.record.data.RowID,e.value);
    }
    function refreshdata(seed,str) {
        CompanyX.RefreshData(seed,str);
    }
    function ReturnNull() {
        var from = "";
        var to = "";
        var shipper = "";
        var consignee = "";
        var est = "";
        var salsman = "";
        var piece = "";
        from = $("#CmbReceipt").val();
        to = $("#CmbFinalDest").val();
        shipper = $("#CmbShipperCode").val();
        consignee = $("#CmbConsignee").val();
        est = $("#txtEst").val();
        salsman = $("#CmbSalesman").val();
        piece = $("#txtPiece").val();
        if ($("#txtHawb").attr("validata") == "false") {
            $("#div_bottom").html("<p class=\"error\">Status : Saved  failed , Error message: the input value is invalid .");
            return false;
        }
        else if (from == "" || from == undefined) {
            $("#CmbReceipt").focus();
            NullMsg("From");
            return false;
        }
        else if (to == "" || to == undefined) {
            $("#CmbFinalDest").focus();
            NullMsg("To");
            return false;
        }
        else if (shipper == "" || shipper == undefined) {
            $("#CmbShipperCode").focus();
            NullMsg("Shipper");
            return false;
        }
        else if (consignee == "" || consignee == undefined) {
            $("#CmbConsignee").focus();
            NullMsg("Consignee");
            return false;
        }
        else if (est == "" || est == undefined) {
            $("#txtEst").focus();
            NullMsg("Est Receipt");
            return false;
        }
        else if (salsman == "" || salsman == undefined) {
            $("#CmbSalesman").focus();
            NullMsg("Salesman");
            return false;
        }
        else if (piece == "" || piece == undefined) {
            $("#txtPiece").focus();
            NullMsg("Piece(s)");
            return false;
        }
        else {
            return true;
        }
    }
    //验证错误信息
    function NullMsg(msg) {
        $("#div_bottom").html("<p class=\"error\">Status :  Saved  failed , Error message: " + msg + " can't be empty!");
    }
    function DeleteHBL(grid) {
        grid.deleteSelected();
        var gwt = 0;
        var vwt = 0;
        var cwt = 0;
        var piece = 0;
        var pallet = 0;
        var status = 0;
        for (var i = 0; i < grid.store.getTotalCount(); ++i) {
            var data = grid.getRowsValues()[i];
            gwt += parseFloat((data.GWT == null || data.GWT=="") ? 0 : data.GWT);
            vwt += parseFloat((data.VWT == null|| data.VWT=="") ? 0 : data.VWT);
            cwt += parseFloat((data.CWT == null || data.CWT == "") ? 0 : data.CWT);
            pallet += parseFloat((data.Pallet == null || data.Pallet == "") ? 0 : data.Pallet);
            piece += parseFloat((data.Piece == null || data.Piece == "") ? 0 : data.Piece);
            status = 1;
        }
        if (status == 1) {
            txtGWT.setValue(gwt);
            txtVWT.setValue(vwt);
            txtCWT.setValue(cwt);
            txtPiece.setValue(piece);
            txtPallet.setValue(pallet);

            lblGWT.setText(Number(gwt).toFixed(3));
            lblVWT.setText(Number(vwt).toFixed(3));
            lblCWT.setText(Number(cwt).toFixed(3));
            lblPiece.setText(Number(piece));
            lblPallet.setText(Number(pallet));
        }
        else {
            txtGWT.setValue("");
            txtVWT.setValue("");
            txtCWT.setValue("");
            txtPiece.setValue("");
            txtPallet.setValue("");

            lblGWT.setText("");
            lblVWT.setText("");
            lblCWT.setText("");
            lblPiece.setText("");
            lblPallet.setText("");
        }
    }
    </script>
    
    <style type="text/css">
         #td_assCosting
        {
            padding-left: 4px !important;
        }
        
         
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager runat="server" ID="ResourceManager" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
    <div id="div_title" style="width: 100%; z-index: 1000">
        <uc1:UserControlTop ID="UserControlTop1" runat="server" sys="A" />
    </div>
  
    <div id="div_title" style="padding-top: 80px; padding-left: 10px; z-index: 990;">
        <table cellpadding="0" cellspacing="0" border="0" width="981px">
            <tr>
                <td style="padding-left: 5px" class="table_nav1 font_11bold_1542af" valign="center"
                    colspan="2">
                    <table border="0" cellspacing="2" cellpadding="0" width="99%">
                        <tbody>
                            <tr>
                                <td width="47%">
                                    <table>
                                        <tr>
                                            <td>
                                                <img src="/images/arrows_btn.png" id="img_showlist" style="cursor: pointer; vertical-align: middle"
                                                    alt="View" onclick="createFrom('AE');" />&nbsp;
                                            </td>
                                            <td>
                                                AE-Sub Shipment
                                            </td>
                                            <td>
                                                &nbsp;<img src="../../images/void.png" runat="server" id="img_void" style="vertical-align: middle;
                                                    display: none;" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td style="padding-right: 5px; font-weight: bold;" class="font_11px_1542af" width="53%"
                                    align="right">
                                    <ext:Label ID="labHeader" runat="server">
                                    </ext:Label>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <ext:Hidden ID="hidVoid" runat="server" Text="0">
    </ext:Hidden>
    <ext:Hidden ID="hidSeed" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="hidMAWB" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="hidLotNo" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="hidIDList" runat="server">
    </ext:Hidden>
    <ext:Container runat="server" ID="div_bottom">
    </ext:Container>
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
    <ext:Store runat="server" ID="StoreShowIn">
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
   
    <ext:Store runat="server" ID="StoreKind">
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
    <ext:Store runat="server" ID="StoreGetItem" OnRefreshData="StoreGetItem_OnRefreshData">
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
    <div style="margin-top: 95px; padding-left: 10px">
        <table border="0" cellspacing="0" cellpadding="0">
            <tbody>
                <tr>
                    <td style="padding-top: 16px" valign="top">
                        <table border="0" cellspacing="4" cellpadding="0" width="675">
                            <tbody>
                                <tr>
                                    <td style="padding-left: 3px" class="font_11bold" align="left">
                                        HAWB
                                    </td>
                                    <td align="left" style="padding-left: 2px">
                                        <ext:TextField ID="txtHawb" runat="server" Cls="select" Width="111" TabIndex="1">
                                            <Listeners>
                                                <Blur Handler="validName(this.id,'HAWB',#{hidSeed}.getValue());" />
                                            </Listeners>
                                        </ext:TextField>
                                    </td>
                                    <td align="left" style="padding-left: 5px">
                                        <table border="0" cellspacing="0" cellpadding="0" width="40">
                                            <tbody>
                                                <tr>
                                                    <td>
                                                        Reference
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                    <td colspan="2" align="left" style="padding-left: 2px">
                                        <ext:TextField ID="txtReference" runat="server" Cls="select" Width="240" TabIndex="2">
                                        </ext:TextField>
                                    </td>
                                    <td align="left">
                                    <table width="70"><tr><td>N/P</td><td  class="font_red" align="right">*</td></tr></table>
                                    </td>
                                    <td valign="center" align="left" style="padding-left: 2px">
                                        <table border="0" cellspacing="0" cellpadding="0">
                                            <tbody>
                                                <tr>
                                                    <td width="85">
                                                        <ext:ComboBox ID="CmbNP" runat="server" Cls="select" DisplayField="value" TabIndex="3"
                                                            ForceSelection="true" Mode="Local" TriggerAction="All" ValueField="value" Width="90">
                                                            <Template Visible="False" ID="ctl935" StopIDModeInheritance="False" EnableViewState="False">
                                                            </Template>
                                                            <Items>
                                                                <ext:ListItem Text="N" Value="N" />
                                                                <ext:ListItem Text="P" Value="P" />
                                                            </Items>
                                                        </ext:ComboBox>
                                                    </td>
                                                    <td width="107">
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="padding-left:1px" align="left">
                                    <table width="73px"><tr><td>Receipt</td><td class="font_red" align="right">*</td></tr></table>
                                    </td>
                                    <td class="font_11px_gray" align="left" style="padding-left: 2px">
                                        <table border="0" cellspacing="0" cellpadding="0" width="100">
                                            <tbody>
                                                <tr>
                                                    <td width="85">
                                                        <uc1:UserComboBox runat="server" ID="CmbReceipt" ListWidth="180" clsClass="select_160px"
                                                            TabIndex="4" Query="option=LocationList&sys=A" StoreID="StoreLocation" Width="90"
                                                            winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=A" winWidth="845"
                                                            winHeight="620" />
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                    <td class="font_11bold" align="left" style="padding-left: 5px">
                                        Dest.<span class="font_red" style="padding-left: 2px">*</span>
                                    </td>
                                    <td width="107" align="left" style="padding-left: 2px">
                                        <table border="0" cellspacing="0" cellpadding="0" width="100">
                                            <tbody>
                                                <tr>
                                                    <td width="85">
                                                        <uc1:UserComboBox runat="server" ID="CmbFinalDest" ListWidth="180" clsClass="select_160px"
                                                            TabIndex="5" Query="option=LocationList&sys=A" StoreID="StoreLocation" Width="90"
                                                            winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=A" winWidth="845"
                                                            winHeight="620" />
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                    <td style="width: 80px" valign="center" align="left">
                                        &nbsp;
                                    </td>
                                    <td align="left">
                                    <table width="70"><tr><td>Est Receipt</td><td  class="font_red" align="right">*</td></tr></table>
                                    </td>
                                    <td align="left" style="padding-left: 2px">
                                        <table border="0" cellspacing="0" cellpadding="0">
                                            <tbody>
                                                <tr>
                                                    <td colspan="2">
                                                        <ext:DateField ID="txtEst" runat="server" Width="90" Cls="text" Format="dd/m/Y" TabIndex="6">
                                                        </ext:DateField>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                                <%--  <tr>
                                    <td style="padding-left: 3px" class="font_11bold" valign="center" align="left">
                                    
                                    </td>
                                    <td  valign="top" colspan="3" align="left">
                                      
                                    </td>
                                    <td valign="center" align="left" colspan="3">
                                      
                                    </td>
                                   
                                </tr>--%>
                                <tr>
                                    <td style="padding-left: 1px" align="left">
                                    <table width="73px"><tr><td>Shipper</td><td class="font_red" align="right">*</td></tr></table>
                                    </td>
                                    <td style="padding-left: 2px" valign="top" colspan="4" align="left">
                                        <table border="0" cellspacing="0" cellpadding="0" width="400">
                                            <tbody>
                                                <tr>
                                                    <td>
                                                        <%--<uc1:UserComboBox runat="server" ID="CmbShipperCode" TabIndex="8" Width="90" clsClass="select_160px"
                                                            StoreID="StoreCmb4" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                            winWidth="800" winHeight="800" Query="option=CompanyList" />--%>
                                                        <uc1:AutoComplete runat="server" ID="CmbShipperCode" TabIndex="5" clsClass="x-form-text x-form-field text"
                                                            Query="option=CompanyList" Width="84" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                            winWidth="800" winHeight="800" />
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                    <td align="left" style="padding-left:2px">
                                        Act Receipt
                                    </td>
                                    <td align="left" style="padding-left: 2px">
                                        <table border="0" cellspacing="0" cellpadding="0">
                                            <tbody>
                                                <tr>
                                                    <td colspan="2">
                                                        <ext:DateField ID="txtAct" runat="server" Width="90" Cls="text" Format="dd/m/Y" TabIndex="7">
                                                        </ext:DateField>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" style="padding-left:1px">
                                    <table width="73px"><tr><td>Consignee</td><td  class="font_red" align="right">*</td></tr></table>
                                    </td>
                                    <td colspan="4" align="left" style="padding-left: 2px">
                                        <table border="0" cellspacing="0" cellpadding="0" width="400">
                                            <tbody>
                                                <tr>
                                                    <td>
                                                        <%-- <uc1:UserComboBox runat="server" ID="CmbConsignee" Query="option=CompanyList" TabIndex="9"
                                                            Width="90" clsClass="select_160px" StoreID="StoreCmb5" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                            winWidth="800" winHeight="800" />--%>
                                                        <uc1:AutoComplete runat="server" ID="CmbConsignee" TabIndex="5" clsClass="x-form-text x-form-field text"
                                                            Query="option=CompanyList" Width="84" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                            winWidth="800" winHeight="800" />
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                    <td align="left">
                                    <table width="70px"><tr><td>Salesman</td><td class="font_red" align="right">*</td></tr></table>
                                    </td>
                                    <td align="left" style="padding-left: 2px">
                                        <table border="0" cellspacing="0" cellpadding="0">
                                            <tbody>
                                                <tr>
                                                    <td width="85">
                                                        <uc1:UserComboBox runat="server" ID="CmbSalesman" TabIndex="12" Query="option=SalesList"
                                                            Width="69" clsClass="select_65" StoreID="StoreSalesman" winTitle="Salesman" winUrl="/BasicData/Salesman/list.aspx"
                                                            winWidth="680" winHeight="560" />
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                    <td valign="center" align="left" style="display: none;">
                                        C/S
                                    </td>
                                    <td align="left" style="display: none;">
                                        <table border="0" cellspacing="0" cellpadding="0" width="100">
                                            <tbody>
                                                <tr>
                                                    <td width="85">
                                                        <ext:TextField ID="txtCS" runat="server" Cls="select" Width="88" ReadOnly="true"
                                                            TabIndex="13">
                                                        </ext:TextField>
                                                    </td>
                                                    <td width="107">
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="padding-bottom: 2px; padding-left: 3px" class="font_11bold" valign="center"
                                        align="left">
                                        Notify #1
                                    </td>
                                    <td colspan="4" align="left" style="padding-left: 2px">
                                        <table border="0" cellspacing="0" cellpadding="0" width="100">
                                            <tbody>
                                                <tr>
                                                    <td>
                                                        <%--<uc1:UserComboBox runat="server" ID="CmbNotify1" Query="option=CompanyList" TabIndex="10"
                                                            Width="90" clsClass="select_160px" StoreID="StoreCmb5" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                            winWidth="800" winHeight="800" />--%>
                                                        <uc1:AutoComplete runat="server" ID="CmbNotify1" TabIndex="5" clsClass="x-form-text x-form-field text"
                                                            Query="option=CompanyList" Width="84" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                            winWidth="800" winHeight="800" />
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                    <td valign="center" align="left">
                                        &nbsp;
                                    </td>
                                    <td valign="top" align="left">
                                        <table border="0" cellspacing="0" cellpadding="0">
                                            <tbody>
                                                <tr>
                                                    <td width="20" style="padding-top: 5px; padding-left: 1px">
                                                        <ext:Checkbox ID="chkSpecial" runat="server" TabIndex="14" Height="10px">
                                                        </ext:Checkbox>
                                                    </td>
                                                    <td style="padding-left: 2px; padding-top: 8px" class="font_11bold" valign="bottom">
                                                        Special Deal
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="padding-left: 3px; padding-top: 2px" class="font_11bold" align="left"
                                        valign="top">
                                        Notify #2
                                    </td>
                                    <td valign="top" colspan="4" align="left" style="padding-left: 2px">
                                        <table border="0" cellspacing="0" cellpadding="0" width="400">
                                            <tbody>
                                                <tr>
                                                    <td>
                                                        <%--<uc1:UserComboBox runat="server" ID="CmbNotify2" Query="option=CompanyList" TabIndex="11"
                                                            Width="90" clsClass="select_160px" StoreID="StoreCmb5" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                            winWidth="800" winHeight="800" />--%>
                                                        <uc1:AutoComplete runat="server" ID="CmbNotify2" TabIndex="5" clsClass="x-form-text x-form-field text"
                                                            Query="option=CompanyList" Width="84" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                            winWidth="800" winHeight="800" />
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                    <td align="left" colspan="2">
                                        &nbsp;
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                    <td style="padding-top: 9px; padding-left: 4px" valign="top">
                        <div id="div_top" style="margin-top: 115px">
                            <table class="table_nav2" border="0" cellspacing="0" cellpadding="0" width="301px"
                                height="25">
                                <tbody>
                                    <tr>
                                        <td class="font_12bold" width="278">
                                            <span class="font_11bold_1542af">&nbsp;&nbsp;Action</span>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <table border="0" cellspacing="0" cellpadding="0" width="280" height="35">
                                <tbody>
                                    <tr align="right" valign="middle">
                                        <td style="padding-bottom: 5px; padding-top: 5px; width: 70px;">
                                            <ext:Button ID="btnNext" runat="server" Width="65px" Text="Next" Hidden="true">
                                                <DirectEvents>
                                                    <Click OnEvent="btnNext_Click">
                                                        <EventMask ShowMask="true" Msg=" Saving ... " />
                                                        <ExtraParams>
                                                             <ext:Parameter Name="gridCost" Value="Ext.encode(#{gridCost}.getRowsValues())" Mode="Raw">
                                                                 </ext:Parameter>
                                                            <ext:Parameter Name="p_safety_2" Value="Ext.encode(#{gpHAWB}.getRowsValues())" Mode="Raw" />
                                                            <ext:Parameter Name="p_safety_invoice" Value="Ext.encode(#{gpInvoice}.getRowsValues())"
                                                                Mode="Raw">
                                                            </ext:Parameter>
                                                        </ExtraParams>
                                                    </Click>
                                                </DirectEvents>
                                            </ext:Button>
                                        </td>
                                        <td style="padding-left: 2px; width: 70px;">
                                            <ext:Button ID="btnVoid" runat="server" Width="65px" Text="Void">
                                                <DirectEvents>
                                                    <Click OnEvent="btnVoid_Click">
                                                    </Click>
                                                </DirectEvents>
                                            </ext:Button>
                                        </td>
                                        <td style="padding-left: 2px; width: 70px;">
                                            <ext:Button ID="btnCancel" runat="server" Width="65px" Text="Cancel">
                                                <DirectEvents>
                                                    <Click OnEvent="btnCancel_Click">
                                                        <EventMask ShowMask="true" Msg=" Loading ... " />
                                                    </Click>
                                                </DirectEvents>
                                            </ext:Button>
                                        </td>
                                        <td style="padding-left: 2px; width: 70px; padding-right: 7px;">
                                            <ext:Button ID="btnSave" runat="server" Width="65px" Text="Save">
                                                <Listeners>
                                                    <Click Handler="return (ReturnNull()&&ValidataText())" />
                                                </Listeners>
                                                <DirectEvents>
                                                    <Click OnEvent="btnSave_Click">
                                                        <EventMask ShowMask="true" Msg=" Saving ... " />
                                                        <ExtraParams>
                                                             <ext:Parameter Name="gridCost" Value="Ext.encode(#{gridCost}.getRowsValues())" Mode="Raw">
                                                                 </ext:Parameter>
                                                            <ext:Parameter Name="p_safety_2" Value="Ext.encode(#{gpHAWB}.getRowsValues())" Mode="Raw" />
                                                            <ext:Parameter Name="p_safety_invoice" Value="Ext.encode(#{gpInvoice}.getRowsValues())"
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
                        </div>
                        <table class="table" border="0" cellspacing="1" cellpadding="0" width="303" bgcolor="#8db2e3"
                            style="margin-top: 82px;">
                            <tbody>
                                <tr>
                                    <td class="font_11bold" bgcolor="#ffffff" height="20" align="left">
                                        <table border="0" cellspacing="0" cellpadding="0" width="61">
                                            <tbody>
                                                <tr>
                                                    <td align="middle">
                                                        GWT
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                    <td bgcolor="#ffffff" height="20" width="99" align="middle">
                                        <ext:NumberField ID="txtGWT" runat="server" Cls="text" Width="64" TabIndex="15" StyleSpec="text-align:right" DecimalPrecision="3">
                                            <Listeners>
                                                <Change Handler="if(this.getValue(true)>#{txtVWT}.getValue(true)){#{txtCWT}.setValue(this.getValue(true));}else{#{txtCWT}.setValue(#{txtVWT}.getValue(true));}" />
                                            </Listeners>
                                        </ext:NumberField>
                                        <table border="0" cellspacing="0" cellpadding="0" width="100%">
                                            <tbody>
                                            </tbody>
                                        </table>
                                    </td>
                                    <td class="font_11bold" bgcolor="#ffffff" height="20" align="middle">
                                        <table border="0" cellspacing="0" cellpadding="0" width="62">
                                            <tbody>
                                                <tr>
                                                    <td align="left" style="padding-left:5px">
                                                        Piece(s)<span class="font_red" style="padding-left: 2px">*</span>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                    <td bgcolor="#ffffff" height="20" width="87" style="padding-left:1px">
                                        <ext:NumberField ID="txtPiece" runat="server" Cls="text" Width="77" DecimalPrecision="1"
                                            StyleSpec="text-align:right" TabIndex="18">
                                        </ext:NumberField>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="font_11bold" bgcolor="#ffffff" height="20" align="middle">
                                        VWT
                                    </td>
                                    <td bgcolor="#ffffff" height="20" align="middle">
                                        <ext:NumberField ID="txtVWT" runat="server" Cls="text" Width="64" TabIndex="16" StyleSpec="text-align:right" DecimalPrecision="3">
                                            <Listeners>
                                                <Change Handler="if(this.getValue(true)>#{txtGWT}.getValue(true)){#{txtCWT}.setValue(this.getValue(true));}else{#{txtCWT}.setValue(#{txtGWT}.getValue(true));}" />
                                            </Listeners>
                                        </ext:NumberField>
                                    </td>
                                    <td class="font_11bold" bgcolor="#ffffff" height="20" align="middle">
                                        Unit
                                    </td>
                                    <td bgcolor="#ffffff" height="20" align="left" style="padding-left: 5px">
                                        <table cellpadding="0" cellspacing="0" border="0">
                                            <tr>
                                                <td>
                                                    <uc1:UserComboBox runat="server" ID="CmbUnit" ListWidth="180" clsClass="select_160px"
                                                        TabIndex="19" Query="option=UnitBinding" StoreID="StoreUnit" Width="56" winTitle="Unit"
                                                        winUrl="/BasicData/Unit/list.aspx" winWidth="510" winHeight="585" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="font_11bold" bgcolor="#ffffff" height="20" align="middle">
                                        CWT
                                    </td>
                                    <td bgcolor="#ffffff" height="20" align="middle">
                                        <ext:NumberField ID="txtCWT" runat="server" Cls="text" Width="64" TabIndex="17" StyleSpec="text-align:right" DecimalPrecision="3">
                                        </ext:NumberField>
                                    </td>
                                    <td class="font_11bold" bgcolor="#ffffff" height="20" align="left" style="padding-left:8px">
                                        Pallet(s)
                                    </td>
                                    <td bgcolor="#ffffff" height="20" style="padding-left:1px">
                                        <ext:NumberField ID="txtPallet" runat="server" Cls="text" Width="77" DecimalPrecision="1"
                                            StyleSpec="text-align:right" TabIndex="20">
                                        </ext:NumberField>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <table border="0" cellspacing="0" cellpadding="0" width="280">
                            <tbody>
                                <tr>
                                    <td height="5" colspan="3">
                                    </td>
                                </tr>
                                <tr>
                                    <td style="padding-left: 140px">
                                    </td>
                                    <td width="62">
                                        <table border="0" cellspacing="0" cellpadding="0" width="66">
                                            <tbody>
                                                <tr>
                                                    <td align="middle">
                                                        <%--CBF--%>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                    <td width="78" align="middle">
                                        <ext:NumberField ID="txtCbf" runat="server" Cls="text" Width="64" TabIndex="21" StyleSpec="text-align:right"
                                            Hidden="true">
                                        </ext:NumberField>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
            </tbody>
        </table>
        <table border="0" cellspacing="0" cellpadding="0">
            <tbody>
                <tr>
                    <td height="8" colspan="2">
                    </td>
                </tr>
                <tr>
                    <td valign="top" colspan="2">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td valign="top">
                                    <table cellpadding="0" cellspacing="0" border="0" width="675">
                                        <tr>
                                            <td class="font_11bold_1542af" style="text-indent: 5px; background-image: url(../../images/bg_line_3.jpg);
                                                border-top: 1px solid #8DB2E3; border-left: 1px solid #8DB2E3; border-right: 1px solid #8DB2E3;
                                                height: 25px">
                                                Local Invoice
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <ext:GridPanel ID="gpInvoice" runat="server" Width="675" Height="131" TrackMouseOver="true"
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
                                                    <ColumnModel ID="ColumnModel7">
                                                        <Columns>
                                                            <ext:RowNumbererColumn Header="#" Width="30">
                                                            </ext:RowNumbererColumn>
                                                            <ext:CheckColumn Header="DN" Width="40" DataIndex="DN" Align="Center">
                                                            </ext:CheckColumn>
                                                            <ext:CheckColumn Header="CN" Width="40" DataIndex="CN" Align="Center">
                                                            </ext:CheckColumn>
                                                            <ext:Column Header="DN/CN No." DataIndex="DN_CNNO" Width="120">
                                                            </ext:Column>
                                                            <ext:Column Header="Company" DataIndex="CompanyName" Width="180">
                                                            </ext:Column>
                                                            <ext:Column Header="CUR" DataIndex="Currency" Width="50" Align="Center">
                                                            </ext:Column>
                                                            <ext:NumberColumn Header="Amount" DataIndex="Amount" Width="70" Align="Right">
                                                            </ext:NumberColumn>
                                                            <ext:CheckColumn Header="Print" DataIndex="Print" Width="40" Align="Center">
                                                            </ext:CheckColumn>
                                                            <ext:CheckColumn Header="Void" DataIndex="Void" Width="38" Align="Center">
                                                            </ext:CheckColumn>
                                                            <ext:CheckColumn Header="AC" DataIndex="AC" Width="38" Align="Center">
                                                            </ext:CheckColumn>
                                                            <%--<ext:ImageCommandColumn Header="Action" Width="50" Align="Center" Hidden="true">
                                                <Commands>
                                                    <ext:ImageCommand Icon="BinEmpty" ToolTip-Text="Delete" CommandName="Delete" Style="background-position: center center;
                                                        width: 60px">
                                                        <ToolTip Text="Delete"></ToolTip>
                                                    </ext:ImageCommand>
                                                </Commands>
                                            </ext:ImageCommandColumn>--%>
                                                        </Columns>
                                                    </ColumnModel>
                                                    <%-- <Listeners>
                                        <Command Handler="DeleteRow(#{gpInvoice},rowIndex)" />
                                    </Listeners>
                                    <KeyMap>
                                        <ext:KeyBinding Ctrl="true">
                                            <Keys>
                                                <ext:Key Code="DELETE" />
                                            </Keys>
                                            <Listeners>
                                                <Event Handler="DeleteRow(#{gpInvoice})" />
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
                                <td valign="top" style="padding-left:5px;">
                                    <uc2:UserSheet ID="UserSheet1" runat="server" disHeader="false" isLoad="true" Height="122" Width="303" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td height="5" colspan="2">
                    </td>
                </tr>
                <tr valign="top">
                    <td width="675">
                        <table style="border-left: #8db2e3 1px solid; border-top: #8db2e3 1px solid; border-right: #8db2e3 1px solid"
                            border="0" cellspacing="0" cellpadding="0" width="675" bgcolor="#8db2e3" height="25">
                            <tbody>
                                <tr>
                                    <td bgcolor="#ffffff" background="../../images/bg_line_3.jpg" align="left">
                                        <table border="0" cellspacing="0" cellpadding="0" width="100%">
                                            <tbody>
                                                <tr>
                                                    <td style="padding-left: 5px" class="font_11bold_1542af" align="left">
                                                        HAWB List
                                                    </td>
                                                    <td style="padding-right: 3px" class="nav_menu_4 font_11px_gray" align="right">
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <ext:Button ID="btnPull" runat="server" Text="Pull Back">
                                                                        <Listeners>
                                                                            <Click Handler="DeleteHBL(#{gpHAWB});" />
                                                                        </Listeners>
                                                                    </ext:Button>
                                                                </td>
                                                                <td>
                                                                    <ext:Button ID="btnNew" runat="server" Text="New Shipment" Width="100">
                                                                        <Menu>
                                                                            <ext:Menu ID="Menu1" runat="server">
                                                                                <Items>
                                                                                    <ext:Button ID="btnShippingNote" Text="New Shipping Note" runat="server" Width="100">
                                                                                        <DirectEvents>
                                                                                            <Click OnEvent="btnShippingNote_Click">
                                                                                                <ExtraParams>
                                                                                                    <ext:Parameter Name="p_safety_3" Value="Ext.encode(#{gpHAWB}.getRowsValues())" Mode="Raw" />
                                                                                                </ExtraParams>
                                                                                            </Click>
                                                                                        </DirectEvents>
                                                                                    </ext:Button>
                                                                                    <ext:Button ID="btnCoLoaderIn" Text="New Co_Loader In" runat="server" Width="100">
                                                                                        <DirectEvents>
                                                                                            <Click OnEvent="btnCoLoaderIn_Click">
                                                                                                <ExtraParams>
                                                                                                    <ext:Parameter Name="p_safety_3" Value="Ext.encode(#{gpHAWB}.getRowsValues())" Mode="Raw" />
                                                                                                </ExtraParams>
                                                                                            </Click>
                                                                                        </DirectEvents>
                                                                                    </ext:Button>
                                                                                    <ext:Button ID="btnCosolManage" Text="Consol Manage" runat="server" Width="100">
                                                                                        <DirectEvents>
                                                                                            <Click OnEvent="btnCosolManage_Click">
                                                                                                <ExtraParams>
                                                                                                    <ext:Parameter Name="p_safety_3" Value="Ext.encode(#{gpHAWB}.getRowsValues())" Mode="Raw" />
                                                                                                </ExtraParams>
                                                                                            </Click>
                                                                                        </DirectEvents>
                                                                                    </ext:Button>
                                                                                </Items>
                                                                            </ext:Menu>
                                                                        </Menu>
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
                    <td style="padding-left:4px" valign="top" rowspan="2">
                        <table border="0" cellspacing="0" cellpadding="0" width="304px" align="left">
                            <tbody>
                                <tr>
                                    <td height="5">
                                        <table border="0" cellspacing="1" cellpadding="0" width="304px" bgcolor="#8db2e3" height="28px">
                                            <tbody>
                                                <tr>
                                                    <td style="padding-left: 5px" class="font_11bold_1542af" bgcolor="#ffffff" background="../../images/bg_line_3.jpg"
                                                        align="left">
                                                        HAWB Summary
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                        <table class="select_142px" border="0" cellspacing="0" cellpadding="0">
                                            <tbody>
                                                <tr>
                                                    <td height="5">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="3" align="left">
                                                        <table width="303px" border="0" cellpadding="0" cellspacing="1" bgcolor="#8DB2E3" class="table">
                                                            <tbody>
                                                                <tr>
                                                                    <td height="20" align="center" bgcolor="#FFFFFF" class="font_11bold">
                                                                        <table width="61" border="0" cellspacing="0" cellpadding="0">
                                                                            <tbody>
                                                                                <tr>
                                                                                    <td align="center">
                                                                                        GWT
                                                                                    </td>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table>
                                                                    </td>
                                                                    <td width="99" height="20" align="center" bgcolor="#FFFFFF">
                                                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                                            <tbody>
                                                                                <tr>
                                                                                    <td align="center">
                                                                                        <ext:Label ID="lblGWT" runat="server">
                                                                                        </ext:Label>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table>
                                                                    </td>
                                                                    <td height="20" align="center" bgcolor="#FFFFFF" class="font_11bold">
                                                                        <table width="62" border="0" cellspacing="0" cellpadding="0">
                                                                            <tbody>
                                                                                <tr>
                                                                                    <td align="center">
                                                                                        Piece(s)
                                                                                    </td>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table>
                                                                    </td>
                                                                    <td width="87" height="20" align="center" bgcolor="#FFFFFF">
                                                                        <ext:Label ID="lblPiece" runat="server">
                                                                        </ext:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td height="20" align="center" bgcolor="#FFFFFF" class="font_11bold">
                                                                        VWT
                                                                    </td>
                                                                    <td height="20" align="center" bgcolor="#FFFFFF">
                                                                        <ext:Label ID="lblVWT" runat="server">
                                                                        </ext:Label>
                                                                    </td>
                                                                    <td height="20" align="center" bgcolor="#FFFFFF" class="font_11bold">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td height="20" align="center" bgcolor="#FFFFFF">
                                                                        &nbsp;
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td height="20" align="center" bgcolor="#FFFFFF" class="font_11bold">
                                                                        CWT
                                                                    </td>
                                                                    <td height="20" align="center" bgcolor="#FFFFFF">
                                                                        <ext:Label ID="lblCWT" runat="server">
                                                                        </ext:Label>
                                                                    </td>
                                                                    <td height="20" align="center" bgcolor="#FFFFFF" class="font_11bold">
                                                                        Pallet(s)
                                                                    </td>
                                                                    <td height="20" align="center" bgcolor="#FFFFFF">
                                                                        <ext:Label ID="lblPallet" runat="server">
                                                                        </ext:Label>
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
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td id="GridView_1" valign="top">
                        <ext:GridPanel ID="gpHAWB" runat="server" Width="675" Height="148" TrackMouseOver="true"
                            StripeRows="true">
                            <Store>
                                <ext:Store runat="server" ID="StoreHAWB">
                                    <Reader>
                                        <ext:JsonReader IDProperty="RowID">
                                            <Fields>
                                                <ext:RecordField Name="RowID" Type="Int">
                                                </ext:RecordField>
                                                <ext:RecordField Name="EstReceipt" Type="Date">
                                                </ext:RecordField>
                                                <ext:RecordField Name="Shipper" Type="String">
                                                </ext:RecordField>
                                                <ext:RecordField Name="SN" Type="String">
                                                </ext:RecordField>
                                                <ext:RecordField Name="DEST" Type="String">
                                                </ext:RecordField>
                                                <ext:RecordField Name="HAWB" Type="String">
                                                </ext:RecordField>
                                                <ext:RecordField Name="GWT" Type="String">
                                                </ext:RecordField>
                                                <ext:RecordField Name="VWT" Type="String">
                                                </ext:RecordField>
                                                <ext:RecordField Name="CWT" Type="String">
                                                </ext:RecordField>
                                                <ext:RecordField Name="Piece" Type="String">
                                                </ext:RecordField>
                                                <ext:RecordField Name="Pallet" Type="String">
                                                </ext:RecordField>
                                                <ext:RecordField Name="Done" Type="String">
                                                </ext:RecordField>
                                            </Fields>
                                        </ext:JsonReader>
                                    </Reader>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="ColumnModel3">
                                <Columns>
                                    <ext:DateColumn Header="Est Receipt" DataIndex="EstReceipt" Width="80" Format="dd/MM/yyyy">
                                    </ext:DateColumn>
                                    <ext:Column Header="Shipper" DataIndex="Shipper" Width="100">
                                    </ext:Column>
                                    <ext:Column Header="SN#" DataIndex="SN" Width="110">
                                    </ext:Column>
                                    <ext:Column Header="Dest." DataIndex="DEST" Width="45" Align="Center">
                                    </ext:Column>
                                    <ext:Column Header="HAWB" DataIndex="HAWB" Width="100">
                                        <Editor>
                                            <ext:TextField ID="edithawb" runat="server">
                                            </ext:TextField>
                                        </Editor>
                                    </ext:Column>
                                    <ext:NumberColumn Header="GWT" DataIndex="GWT" Width="55" Format="0.000" Align="Right">
                                    </ext:NumberColumn>
                                    <ext:NumberColumn Header="VWT" DataIndex="VWT" Width="55" Format="0.000" Align="Right">
                                    </ext:NumberColumn>
                                    <ext:NumberColumn Header="CWT" DataIndex="CWT" Width="55" Format="0.000" Align="Right">
                                    </ext:NumberColumn>
                                    <ext:NumberColumn Header="Piece" DataIndex="Piece" Width="65" Format="0" Align="Right">
                                    </ext:NumberColumn>
                                    <ext:Column Header="Done" DataIndex="Done" Width="60" Align="Center">
                                    </ext:Column>
                                </Columns>
                            </ColumnModel>
                            <Listeners>
                                <AfterEdit Fn="afterEdit" />
                            </Listeners>
                            <SelectionModel>
                                <ext:RowSelectionModel ID="RowSelectionModel3" runat="server" SingleSelect="false">
                                </ext:RowSelectionModel>
                            </SelectionModel>
                        </ext:GridPanel>
                    </td>
                </tr>
                <tr>
                    <td height="5" colspan="2">
                    </td>
                </tr>
                <tr>
                <td colspan="2">
                <uc1:Costing ID="ucCost"  runat="server" type="H2"  sys="AE"/>
                </td>
                </tr>
                <tr>
                    <td height="10" colspan="2">
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <br />
    <br />
    </form>
</body>
</html>
