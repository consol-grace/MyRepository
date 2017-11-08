<%@ Page Language="C#" AutoEventWireup="true" CodeFile="List.aspx.cs" Inherits="AirExport_AEMakeConsol_List" %>

<%@ Register Src="../../common/UIControls/UserSheet.ascx" TagName="UserSheet" TagPrefix="uc2" %>
<%@ Register Src="../../common/UIControls/UserControlTop.ascx" TagName="UserControlTop"
    TagPrefix="uc1" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<%@ Register Src="../../common/UIControls/UserComboBox.ascx" TagName="UserComboBox"
    TagPrefix="uc1" %>
<%@ Register Src="../../common/UIControls/AutoComplete.ascx" TagName="AutoComplete"
    TagPrefix="uc1" %>
 <%@ Register src="/common/UIControls/Costing.ascx" tagname="Costing" tagprefix="uc1" %> 
  <%@ Register Src="../../common/UIControls/Transfer.ascx" TagName="Transfer"
    TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>
        <%=Request["type"] == "c" ? "AE Make Consol" : "AE Coloader Out"%></title> 
    <link href="/css/style.css" rel="stylesheet" type="text/css" />

    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script> 

    <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>

    <script src="../../common/ylQuery/Grid.js" type="text/javascript"></script>

    <script src="../../common/UIControls/CompanyDrpList.js" type="text/javascript"></script>

    <script src="../../AirExport/AEValid/Valid.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function TabSum(grid) {

            if (grid == null) return;
            var count = grid.store.getTotalCount();

            if (count > 0) {
                if (grid.getRowsValues({ Selectedonly: false })[0].Carrier != "") {
                    CmbCarrierRight.setValue(grid.getRowsValues({ Selectedonly: false })[0].Carrier);
                }
                if (grid.getRowsValues({ Selectedonly: false })[0].FlightNo != "") {
                    txtFlightRight.setValue(grid.getRowsValues({ Selectedonly: false })[0].FlightNo);
                }
                if (grid.getRowsValues({ Selectedonly: false })[0].From != "") {
                    CmbFromRight.setValue(grid.getRowsValues({ Selectedonly: false })[0].From);
                }
                if (grid.getRowsValues({ Selectedonly: false })[count - 1].To != "") {
                    CmbToRight.setValue(grid.getRowsValues({ Selectedonly: false })[count - 1].To);
                }
                if (grid.getRowsValues({ Selectedonly: false })[0].ETD != undefined) {
                    txtETD.setValue(grid.getRowsValues({ Selectedonly: false })[0].ETD);
                }
                if (grid.getRowsValues({ Selectedonly: false })[count - 1].ETA != undefined) {
                    txtETA.setValue(grid.getRowsValues({ Selectedonly: false })[count - 1].ETA);
                }
                if (grid.getRowsValues({ Selectedonly: false })[0].ATD != undefined) {
                    txtATD.setValue(grid.getRowsValues({ Selectedonly: false })[0].ATD);
                }
                if (grid.getRowsValues({ Selectedonly: false })[count - 1].ATA != undefined) {
                    txtATA.setValue(grid.getRowsValues({ Selectedonly: false })[count - 1].ATA);
                }
            }
            else {
                txtFlightRight.setValue("");
                CmbFromRight.setValue("");
                CmbToRight.setValue("");
                txtETD.setValue("");
                txtETA.setValue("");
                txtATD.setValue("");
                txtATA.setValue("");
            }
        }


        function PullBack(grid) {
            var selectValue = "";
            var str = new Array();

            for (var i = 0; i < grid.getRowsValues({ selectedOnly: true }).length; ++i) {
                if (grid.getRowsValues({ selectedOnly: true })[i].Type != "0") {
                    selectValue += grid.getRowsValues({ selectedOnly: true })[i].Type + ",";
                }
            }
            grid.deleteSelected();
            if (selectValue.length > 0) {
                selectValue = selectValue.substr(0, selectValue.length - 1);
                str = selectValue.split(",");
                for (var j = 0; j < str.length; ++j) {
                    for (var i = 0; i < grid.store.getTotalCount(); ++i) {
                        if (str[j] == grid.getRowsValues()[i].Type) {
                            grid.getSelectionModel().selectRow(i);
                            grid.deleteSelected();
                            --i;
                        }
                    }
                }
            }

            var gwt = 0.0;
            var vwt = 0.0;
            var cwt = 0.0;
            var piece = 0.0;
            var pallet = 0.0;
            var status = 0;
            for (var i = 0; i < grid.store.getTotalCount(); ++i) {
                var data = grid.getRowsValues()[i];
                if (parseFloat(data.IsSub) == 0) {
                    gwt += parseFloat((data.GWT == "" || data.GWT == null) ? 0 : data.GWT);
                    vwt += parseFloat((data.VWT == "" || data.VWT == null) ? 0 : data.VWT);
                    cwt += parseFloat((data.CWT == "" || data.CWT == null) ? 0 : data.CWT);
                    piece += parseFloat((data.Piece == "" || data.Piece == null) ? 0 : data.Piece);
                    pallet += parseFloat((data.Pallet == "" || data.Pallet == null) ? 0 : data.Pallet);
                }
                status = 1;
            }
            if (status == 1) {
                lblGWT.setText(gwt.toFixed(3));
                lblVWT.setText(vwt.toFixed(3));
                lblCWT.setText(cwt.toFixed(3));
                lblPiece.setText(piece);
                lblPallet.setText(pallet);
            }
            else {
                lblGWT.setText("");
                lblVWT.setText("");
                lblCWT.setText("");
                lblPiece.setText("");
                lblPallet.setText("");
            }
        }

        var selectFRowIndex = -1;
        function GetFRowID(row) {
            selectFRowIndex = row;
        }
        function InsertFRecord() {
            var flightno = $("#l_flightno").val().toUpperCase();
            var from = $("#l_from").val();
            var to = $("#l_to").val();
            var etd = $("#l_etd").val();
            var eta = $("#l_eta").val();
            var atd = $("#l_atd").val();
            var ata = $("#l_ata").val();
            var carrier = $("#l_CmbCarrierRight").val();

            if (carrier == "" || carrier == undefined) {
                $("#l_CmbCarrierRight").focus();
                NullMsg("Carrier");
                return;
            }
            if (flightno == "" || flightno == undefined) {
                $("#l_flightno").focus();
                NullMsg("Flight No");
                return;
            }
            if (from == "" || from == undefined) {
                $("#l_from").focus();
                NullMsg("From");
                return;
            }
            if (to == "" || to == undefined) {
                $("#l_to").focus();
                NullMsg("To");
                return;
            }
            if (etd == "" || etd == undefined) {
                $("#l_etd").focus();
                NullMsg("ETD");
                return;
            }
            if (eta == "" || eta == undefined) {
                $("#l_eta").focus();
                NullMsg("ETA");
                return;
            }


            var count = GridFlightList.store.getTotalCount();  // 获取当前行数
            if (selectFRowIndex >= 0) {
                var record = GridFlightList.getStore().getAt(selectFRowIndex); // 获取当前行的数据
                if (isMawbFlag == 'Y' && selectFRowIndex == 0) {
                    record.set("To", to);
                    record.set("ATD", atd);
                    record.set("ATA", ata);
                    record.set("Carrier", carrier);
                }
                else {
                    record.set("FlightNo", flightno);
                    record.set("From", from);
                    record.set("To", to);
                    record.set("ETD", etd);
                    record.set("ETA", eta);
                    record.set("ATD", atd);
                    record.set("ATA", ata);
                    record.set("Carrier", carrier);
                }
            }
            else {
                GridFlightList.insertRecord(count, { FlightNo: flightno, From: from, To: to, ETD: etd, ETA: eta, ATD: atd, ATA: ata, Carrier: carrier });
            }
            GridFlightList.getView().refresh();
            GridFlightList.view.focusEl.focus();
            ResetFRecord();
            TabSum(GridFlightList);

        }

        function SelectFRecord() {
            var record = GridFlightList.getStore().getAt(selectFRowIndex); // 获取当前行的数据
            if (record == null || record == undefined)
                return;
            else {
                $("#l_flightno").val(record.data.FlightNo);
                $("#l_from").val(record.data.From);
                $("#l_to").val(record.data.To);
                $("#l_etd").val(record.data.ETD);
                $("#l_eta").val(record.data.ETA);
                $("#l_atd").val(record.data.ATD);
                $("#l_ata").val(record.data.ATA);
                $("#l_CmbCarrierRight").val(record.data.Carrier);
            }
        }

        function DeleteFRecord() {
            GridFlightList.getSelectionModel().selectRow(selectFRowIndex);
            GridFlightList.deleteSelected();
            ResetFRecord();
            TabSum(GridFlightList);
        }

        function ResetFRecord() {
            selectFRowIndex = -1;
            $("#l_flightno").val("");
            $("#l_from").val("");
            $("#l_to").val("");
            $("#l_etd").val("");
            $("#l_eta").val("");
            $("#l_atd").val("");
            $("#l_ata").val("");
            $("#l_CmbCarrierRight").val("");
            $("#l_CmbCarrierRight").focus();
        }


        function refreshdata(seed, str) {
            CompanyX.RefreshData(seed, str);
        }

        function ReturnNull() {
            var shipper = "";
            var consignee = "";
            shipper = $("#CmbShipperCode").val();
            consignee = $("#CmbConsignee").val();
            if ($("#txtMAWB").attr("validata") == "false") {
                $("#div_bottom").html("<p class=\"error\">Status : Saved  failed , Error message: the input value is invalid .");
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
            else if (GridFlightList.store.getTotalCount() == 0) {
            $("#l_CmbCarrierRight").focus();
            NullMsg("Flight Routing");
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

        function ChangeMawb(event) {
            if (event.keyCode == 8 || event.keyCode == 46) {
                return false;
            }
            else if ($("#txtMAWB").val().length == 3) {
                $("#txtMAWB").val($("#txtMAWB").val() + ' ');
                return true;
            }
        }
        function ChangeFlight() {
            if ($("#l_flightno").val() == "" && $("#l_CmbCarrierRight").val() != "") {
                $("#l_flightno").val($("#l_CmbCarrierRight").val() + ' ');
                getSelectPos("l_flightno");
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
        $(function() {
            if (Request("type") == "d") {
                $("#CmbShipperCode").blur(function() {
                if ($("#CmbColoader").val() == "") {
                        $("#CmbColoader").val($("#CmbShipperCode").val());
                    }
                })
            }
        })
    </script>
     

</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager runat="server" ID="ResourceManager" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
    <div id="div_title" style="width: 100%; z-index: 1000">
        <uc1:UserControlTop ID="UserControlTop1" runat="server" sys="A" />
    </div>
    
    <div id="div_title" style="margin-left: 10px; margin-top: 80px;z-index:990;">
        <table cellpadding="0" cellspacing="0" border="0" width="980px" class="table_nav1 font_11bold_1542af">
            <tr>
                <td style="padding-left: 5px">
                    <table>
                        <tr>
                            <td>
                            <img src="/images/arrows_btn.png" id="img_showlist" style="cursor: pointer; vertical-align: middle"
                                    alt="View" onclick="createFrom('AE');" />&nbsp;
                            </td><td><%=Request["type"] == "c" ? "AE-Make Consol" : "AE-Coloader Out"%></td>
                            <td  style="padding-top:2px;">&nbsp;<img src="../../images/void.png" runat="server" id="img_void" style="vertical-align: middle; display:none;" /></td>
                          </tr>
                     </table>
                   </td>
                   <td align="right"  style="padding-right: 5px; font-weight: bold;">
                                <table border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td align="right">
                                            <ext:Button ID="btnUpdateLotNo" runat="server" Hidden="true" Text="Update Lot No."
                                                Cls="btnUpdateLotNo">
                                                <Listeners>
                                                    <Click Handler="UpdatelotNo();" />
                                                </Listeners>
                                            </ext:Button>
                                        </td>
                                        <td style="padding-left: 5px;">
                                            <%if (Request["seed"] != null)
                                              { %>
                                            Lot#&nbsp;<%} %>
                                        </td>
                                        <td style="padding-left: 5px;">
                                            <ext:Label ID="labLotNo" runat="server" StyleSpec="color:#ff0000;font-size:10px">
                                            </ext:Label>
                                        </td>
                                        <td>
                 <%if (!string.IsNullOrEmpty(Request["seed"]))
                 { %>
                  <uc1:Transfer runat="server" ID="TransferSys" sys="AE" type="M"/>
                   <%} %>
                  </td>
                                    </tr>
                                </table>
                   </td>
            </tr>
        </table>
    </div>
        <ext:Hidden ID="hidVoid" runat="server" Text="0">
    </ext:Hidden>
    <ext:Hidden ID="hidSeed" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="hidLotNo" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="hidIDList" runat="server">
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
    <ext:Store runat="server" ID="StoreKind">
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
    <ext:Container runat="server" ID="div_bottom">
    </ext:Container>
    <div style="margin-top: 112px; padding-left: 10px">
        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td valign="top" style="padding-top: 5px">
                    <table cellpadding="0" cellspacing="0" border="0" width="672px">
                        <tr>
                            <td valign="top" style="padding-left: 5px">
                                <table border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td align="left" class="font_11bold" style="padding-left: 3px; height: 25px">MAWB</td>
                                        <td width="84" align="left" colspan="3">
                                            <ext:TextField ID="txtMAWB" runat="server" Cls="select" Width="87" TabIndex="1" EnableKeyEvents="true">
                                                <Listeners>
                                                    <Blur Handler="validName(this.id,'MAWB',#{hidSeed}.getValue());" />
                                                    <KeyUp Handler="ChangeMawb(event);" />
                                                </Listeners>
                                            </ext:TextField>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  align="left" style="padding-left:1px"><table width="75px"><tr><td>Shipper</td><td class="font_red" align="right">*</td></tr></table></td>
                                        <td colspan="3" align="left" class="font_11px_gray" style="padding-top: 4px">
                                            <table width="255" border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="85">
                                                        <%--<uc1:UserComboBox runat="server" ID="CmbShipperCode" Query="option=CompanyList" clsClass="select_160px"
                                                Width="100" TabIndex="4" StoreID="StoreCmb2" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                winWidth="800" winHeight="800" />--%>
                                                        <uc1:AutoComplete runat="server" ID="CmbShipperCode" TabIndex="4" clsClass="x-form-text x-form-field text"
                                                            Query="option=CompanyList" Width="60" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                            winWidth="800" winHeight="800" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" style="padding-left:1px">
                                        <table width="75px"><tr><td>Consignee</td><td class="font_red" align="right">*</td></tr></table>
                                        </td>
                                        <td colspan="3" align="left" style="padding-top: 6px">
                                            <table width="255" border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="85">
                                                        <%--<uc1:UserComboBox runat="server" ID="CmbConsignee" Query="option=CompanyList" clsClass="select_160px"
                                                Width="100" TabIndex="5" StoreID="StoreCmb2" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                winWidth="800" winHeight="800" />--%>
                                                        <uc1:AutoComplete runat="server" ID="CmbConsignee" TabIndex="5" clsClass="x-form-text x-form-field text"
                                                            Query="option=CompanyList" Width="60" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                            winWidth="800" winHeight="800" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" valign="top" class="font_11bold" style="padding-left: 3px; padding-right: 3px;
                                            padding-top: 6px">
                                            <div id="showColoader1" runat="server">
                                            Co-Loader</div>
                                        </td>
                                        <td colspan="3" align="left" style="padding-top: 6px">
                                            <table width="255" border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="85">  <div id="showColoader2" runat="server"> 
                                                       <uc1:AutoComplete runat="server" ID="CmbColoader" TabIndex="5" clsClass="x-form-text x-form-field text"
                                                            Query="option=CompanyList" Width="61" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                            winWidth="800" winHeight="800"/></div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td valign="top" style="padding-top: 3px">
                                <table border="0" cellpadding="0" cellspacing="0" class="select_142px" style="border: 1px solid #8db2e3;
                                    width: 335px; height: 70px">
                                    <tr>
                                        <td height="0" align="left" style="padding-left: 6px">
                                            <table width="35" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td align="left">
                                                        Carrier
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td height="0">
                                            <table width="68" border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="68">
                                                        <uc1:UserComboBox runat="server" ID="CmbCarrierRight" isButton="false" HideTrigger="true"
                                                            ListWidth="180" clsClass="select_160px input_line_white" TabIndex="8" Query="option=LocationList&sys=A"
                                                            StoreID="StoreLocation" Width="88" winTitle="Location" winUrl="/BasicData/Customer/detail.aspx"
                                                            winWidth="845" winHeight="620" Disabled="true" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="padding-left: 4px;">
                                            <table width="60" border="0" cellspacing="0" cellpadding="0"><tr><td>Flight No.</td></tr></table>
                                        </td>
                                        <td valign="middle" class="font_11px_gray" style="width: 80px">
                                            <ext:TextField AllowBlank="false" ID="txtFlightRight" runat="server" Cls="text input_line_white " TabIndex="7"
                                                Disabled="true" Width="88">
                                            </ext:TextField>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="0" style="padding-left: 6px">
                                            From
                                        </td>
                                        <td height="0">
                                            <table width="68" border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="68">
                                                        <uc1:UserComboBox runat="server" ID="CmbFromRight" isButton="false" HideTrigger="true"
                                                            ListWidth="180" clsClass="select_160px input_line_white" TabIndex="8" Query="option=LocationList&sys=A"
                                                            StoreID="StoreLocation" Width="68" winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=A"
                                                            winWidth="845" winHeight="620" Disabled="true" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="padding-left: 4px;">
                                            To
                                        </td>
                                        <td>
                                            <table border="0" cellpadding="0" cellspacing="0" width="80px">
                                                <tr>
                                                    <td>
                                                        <uc1:UserComboBox runat="server" ID="CmbToRight" ListWidth="180" clsClass="select_160px input_line_white"
                                                            TabIndex="9" Query="option=LocationList&sys=A" StoreID="StoreLocation" Width="68"
                                                            winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=A" winWidth="845"
                                                            winHeight="620" Disabled="true" HideTrigger="true" isButton="false" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 6px">
                                            ETD
                                        </td>
                                        <td align="left" id="GridView_5">
                                            <span class="font_11px_gray">
                                                <ext:DateField ID="txtETD" runat="server" Cls="text input_line_white" Width="88"
                                                    Format="dd/m/Y" TabIndex="10" Disabled="true" HideTrigger="true">
                                                    <%-- <Listeners>
                                                        <Change Handler="if(#{txtATD}.getValue(true)==''){#{txtATD}.setValue(this.getValue())}" />
                                                    </Listeners>--%>
                                                </ext:DateField>
                                            </span>
                                        </td>
                                        <td align="left" id="GridView_5" style="padding-left: 4px">
                                            ETA
                                        </td>
                                        <td align="left" id="GridView_5">
                                            <span class="font_11px_gray">
                                                <ext:DateField ID="txtETA" runat="server" Cls="text input_line_white" Width="88"
                                                    Format="dd/m/Y" TabIndex="11" Disabled="true" HideTrigger="true">
                                                    <%-- <Listeners>
                                                        <Change Handler="if(#{txtATA}.getValue(true)==''){#{txtATA}.setValue(this.getValue())}" />
                                                    </Listeners>--%>
                                                </ext:DateField>
                                            </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 6px">
                                            ATD
                                        </td>
                                        <td height="-2" align="left" id="GridView_5">
                                            <span class="font_11px_gray">
                                                <ext:DateField ID="txtATD" runat="server" Cls="text input_line_white" Width="88"
                                                    Format="dd/m/Y" TabIndex="12" Disabled="true" HideTrigger="true">
                                                </ext:DateField>
                                            </span>
                                        </td>
                                        <td align="left" id="GridView_5" style="padding-left: 4px">
                                            <table cellpadding="0" cellspacing="0" border="0" width="30">
                                                <tr>
                                                    <td>
                                                        ATA
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td align="left" id="GridView_5">
                                            <span class="font_11px_gray">
                                                <ext:DateField ID="txtATA" runat="server" Cls="text input_line_white" Width="88"
                                                    Format="dd/m/Y" TabIndex="13" Disabled="true" HideTrigger="true">
                                                </ext:DateField>
                                            </span>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
                <td valign="top" style="padding-left: 5px; padding-top: 9px">
                    <div id="div_top" style="margin-top: 120px">
                        <table width="301px" height="25" border="0" cellpadding="0" cellspacing="0" class="table_nav2">
                            <tr>
                                <td width="301px" class="font_12bold">
                                    <span class="font_11bold_1542af">&nbsp;&nbsp;Action</span>
                                </td>
                            </tr>
                        </table>
                        <table width="260" height="42" border="0" align="right" cellpadding="0" cellspacing="0">
                            <tr>
                                <td class="table" style="padding-bottom: 5px; padding-top: 5px">
                                    <ext:Button ID="btnNext" runat="server" Width="65px" Text="Next" Hidden="true">
                                        <Listeners>
                                            <Click Handler="(ReturnNull()&&ValidataText());" />
                                        </Listeners>
                                        <DirectEvents>
                                            <Click OnEvent="btnNext_Click">
                                                <EventMask ShowMask="true" Msg=" Saving ... " />
                                                <ExtraParams>
                                                      <ext:Parameter Name="gridCost" Value="Ext.encode(#{gridCost}.getRowsValues())" Mode="Raw">
                                                                 </ext:Parameter>
                                                    <ext:Parameter Name="p_safety_l" Value="Ext.encode(#{GridFlightList}.getRowsValues())"
                                                        Mode="Raw" />
                                                    <ext:Parameter Name="p_safety_2" Value="Ext.encode(#{gpHAWB}.getRowsValues())" Mode="Raw" />
                                                    <ext:Parameter Name="p_safety_3" Value="Ext.encode(#{gpInvoice}.getRowsValues())"
                                                        Mode="Raw" />
                                                   
                                                </ExtraParams>
                                            </Click>
                                        </DirectEvents>
                                    </ext:Button>
                                </td>
                                <td class="table" style="padding-left: 2px; width: 70px;">
                                    <ext:Button ID="btnVoid" runat="server" Width="65px" Text="Void">
                                        <DirectEvents>
                                            <Click OnEvent="btnVoid_Click">
                                            </Click>
                                        </DirectEvents>
                                    </ext:Button>
                                </td>
                                <td class="table" style="padding-left: 2px; width: 70px;">
                                    <ext:Button ID="btnCancel" runat="server" Width="65px" Text="Cancel">
                                        <DirectEvents>
                                            <Click OnEvent="btnCancel_Click">
                                                <EventMask ShowMask="true" Msg=" Waiting ... " />
                                            </Click>
                                        </DirectEvents>
                                    </ext:Button>
                                </td>
                                <td class="table" style="padding-left: 2px; width: 70px; padding-right: 3px;">
                                    <ext:Button ID="btnSave" runat="server" Width="65px" Text="Save">
                                        <Listeners>
                                            <Click Handler="return  (ReturnNull()&&ValidataText());" />
                                        </Listeners>
                                        <DirectEvents>
                                            <Click OnEvent="btnSave_Click">
                                                <EventMask ShowMask="true" Msg=" Saving ... " />
                                                <ExtraParams>
                                                     <ext:Parameter Name="gridCost" Value="Ext.encode(#{gridCost}.getRowsValues())" Mode="Raw">
                                                                 </ext:Parameter>
                                                    <ext:Parameter Name="p_safety_l" Value="Ext.encode(#{GridFlightList}.getRowsValues())"
                                                        Mode="Raw" />
                                                    <ext:Parameter Name="p_safety_2" Value="Ext.encode(#{gpHAWB}.getRowsValues())" Mode="Raw" />
                                                    <ext:Parameter Name="p_safety_3" Value="Ext.encode(#{gpInvoice}.getRowsValues())"
                                                        Mode="Raw" />
                                                   
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
                <td align="right" valign="top" style="padding-top: 5px">
                    <table style="float:left;" cellpadding="0" cellspacing="0">
                        <tr>

                             <td style=" padding-left: 8px;  padding-right: 18px;width:55px;">Salesman</td>
                            <td><uc1:UserComboBox runat="server" ID="CmbSalesman" TabIndex="5" Width="67" clsClass="select_65"
                                                                        StoreID="StoreSalesman" winTitle="Salesman" winUrl="/BasicData/Salesman/list.aspx"
                                                                        winWidth="680" winHeight="560" />
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

                            </td> 
                        </tr>

                    </table>
                    <table border="0" cellpadding="0" cellspacing="1" bgcolor="#8DB2E3" class="table" style="float:right;"
                        width="445px">
                        <tr>                           
                            <td align="center" bgcolor="#FFFFFF" class="font_11bold">
                                GWT
                            </td>
                            <td align="center" bgcolor="#FFFFFF" class="font_11bold">
                                VWT
                            </td>
                            <td bgcolor="#FFFFFF" align="center" class="font_11bold">
                                CWT
                            </td>
                            <td align="center" bgcolor="#FFFFFF" class="font_11bold">
                                Piece(s)
                            </td>
                            <td bgcolor="#FFFFFF" align="center" class="font_11bold">
                                Pallet(s)
                            </td>
                            <td align="center" bgcolor="#FFFFFF" class="font_11bold">
                                Rate
                            </td>
                        </tr>
                        <tr>
                            <td class="table_25px" align="left" bgcolor="#FFFFFF" style="padding-left: 3px; padding-right: 3px">
                                <ext:NumberField ID="txtGWT" runat="server" Cls="text" Width="60" TabIndex="5" StyleSpec="text-align:right" DecimalPrecision="3">
                                    <Listeners>
                                        <Blur Handler="if(this.getValue(true)>#{txtVWT}.getValue(true)){#{txtCWT}.setValue(this.getValue(true));}else{#{txtCWT}.setValue(#{txtVWT}.getValue(true));}" />
                                    </Listeners>
                                </ext:NumberField>
                            </td>
                            <td align="left" bgcolor="#FFFFFF" style="padding-left: 3px; padding-right: 3px">
                                <ext:NumberField ID="txtVWT" runat="server" Cls="text" Width="60" TabIndex="5" StyleSpec="text-align:right" DecimalPrecision="3">
                                    <Listeners>
                                        <Blur Handler="if(this.getValue(true)>#{txtGWT}.getValue(true)){#{txtCWT}.setValue(this.getValue(true));}else{#{txtCWT}.setValue(#{txtGWT}.getValue(true));}" />
                                    </Listeners>
                                </ext:NumberField>
                            </td>
                            <td align="left" bgcolor="#FFFFFF" style="padding-left: 3px; padding-right: 3px">
                                <ext:NumberField ID="txtCWT" runat="server" Cls="text" Width="60" TabIndex="5" StyleSpec="text-align:right" DecimalPrecision="3">
                                </ext:NumberField>
                            </td>
                            <td align="left" bgcolor="#FFFFFF" style="padding-left: 3px; padding-right: 3px">
                                <ext:NumberField ID="txtPiece" runat="server" Cls="text" Width="60" DecimalPrecision="1"
                                    StyleSpec="text-align:right" TabIndex="5">
                                </ext:NumberField>
                            </td>
                            <td align="left" bgcolor="#FFFFFF" style="padding-left: 3px; padding-right: 3px">
                                <ext:NumberField ID="txtPallet" runat="server" Cls="text" Width="60" DecimalPrecision="1"
                                    StyleSpec="text-align:right" TabIndex="5">
                                </ext:NumberField>
                            </td>
                            <td align="left" bgcolor="#FFFFFF" style="padding-left: 3px; padding-right: 3px">
                                <ext:NumberField ID="txtRate" runat="server" Cls="text" Width="60"  DecimalPrecision="3"
                                    StyleSpec="text-align:right" TabIndex="5">
                                </ext:NumberField>
                            </td>
                        </tr>
                    </table>

                </td>
                <td class="font_11bold" style="padding-left: 5px; padding-bottom:40px;">Remark</td>
                <%--   添加REMARK GRACE --%>
                <td style="padding-left: 10px;padding-top: 3px">
                     <ext:TextArea ID="txtRemark" runat="server" TabIndex="6" Height="53px" Width="253px" Cls="text_80px">
                     </ext:TextArea>
                </td>
            </tr>
        </table>
        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td colspan="2" height="8">
                </td>
            </tr>
            <tr>
                <td valign="top" id="GridView_1" align="left">
                    <table cellpadding="0" cellspacing="0" border="0" width="672">
                        <tr>
                            <td class="font_11bold_1542af" style="text-indent: 5px; background-image: url(../../images/bg_line_3.jpg);
                                border-top: 1px solid #8DB2E3; border-left: 1px solid #8DB2E3; border-right: 1px solid #8DB2E3;
                                height: 23px">
                                Flight Routing
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <ext:GridPanel ID="GridFlightList" runat="server" Width="672" Height="131" TrackMouseOver="true"
                                    ColumnLines="True">
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
                                                        <ext:RecordField Name="ETD" Type="string">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="ETA" Type="string">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="ATD" Type="string">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="ATA" Type="string">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Carrier" Type="string">
                                                        </ext:RecordField>
                                                    </Fields>
                                                </ext:JsonReader>
                                            </Reader>
                                        </ext:Store>
                                    </Store>
                                    <ColumnModel ID="clmFlight">
                                        <Columns>
                                            <ext:RowNumbererColumn Header="#" Width="30">
                                            </ext:RowNumbererColumn>
                                            <ext:Column Header="Flight No." DataIndex="FlightNo" Width="155">
                                            </ext:Column>
                                            <ext:Column Header="From" DataIndex="From" Width="62" Align="Center">
                                            </ext:Column>
                                            <ext:Column Header="To" DataIndex="To" Width="62" Align="Center">
                                            </ext:Column>
                                            <ext:Column Header="ETD" DataIndex="ETD" Width="85" Align="Center">
                                            </ext:Column>
                                            <ext:Column Header="ETA" DataIndex="ETA" Width="85" Align="Center">
                                            </ext:Column>
                                            <ext:Column Header="ATD" DataIndex="ATD" Width="85" Align="Center">
                                            </ext:Column>
                                            <ext:Column Header="ATA" DataIndex="ATA" Width="85" Align="Center">
                                            </ext:Column>
                                        </Columns>
                                    </ColumnModel>
                                    <Listeners>
                                        <RowClick Handler="GetFRowID(rowIndex);SelectFRecord();" />
                                    </Listeners>
                                    <SelectionModel>
                                        <ext:RowSelectionModel runat="server" ID="ctl5836">
                                            <Listeners>
                                                <RowSelect Handler="GetFRowID(rowIndex);" />
                                            </Listeners>
                                        </ext:RowSelectionModel>
                                    </SelectionModel>
                                </ext:GridPanel>
                            </td>
                        </tr>
                    </table>
                </td>
                <td valign="top" style="padding-left: 5px">
                    <div id="isMawbFlag" runat="server">

                        <script type="text/javascript">
                            var isMawbFlag = 'N';
                        </script>

                        <table width="303" border="0" align="left" cellpadding="0" cellspacing="0">
                            <tr>
                                <td height="5">
                                    <table width="303" height="25" border="0" cellpadding="0" cellspacing="1" bgcolor="8db2e3">
                                        <tr>
                                            <td align="left" background="../../images/bg_line_3.jpg" bgcolor="#FFFFFF" class="font_11bold_1542af"
                                                style="padding-left: 5px">
                                                Add Flight
                                            </td>
                                        </tr>
                                    </table>
                                    <table border="0" cellpadding="0" cellspacing="0" class="select_142px">
                                        <tr>
                                            <td height="5" colspan="4">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding-left: 3px">
                                            <table width="50px"><tr><td>Carrier</td><td  class="font_red" align="right">*</td></tr></table>
                                            </td>
                                            <td height="0" style="padding-right: 2px">
                                                <table width="70" border="0" cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td width="70">
                                                            <uc1:AutoComplete runat="server" ID="l_CmbCarrierRight" TabIndex="6" clsClass="x-form-text x-form-field text"
                                                                Query="option=CompanyList" Width="61" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"
                                                                winWidth="800" winHeight="800" isDiplay="false" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td height="25" style="padding-left:5px">
                                            <table width="65px"><tr><td align="left">Flight No.</td><td class="font_red" align="right">*</td></tr></table>
                                            </td>
                                            <td height="0">
                                                <table width="70" border="0" cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td width="70">
                                                            <ext:TextField ID="l_flightno" runat="server" Cls="text" TabIndex="6">
                                                                <Listeners>
                                                                    <Focus Handler="ChangeFlight();" />
                                                                </Listeners>
                                                            </ext:TextField>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding-left: 3px">
                                             <table width="50px"><tr><td>From</td><td  class="font_red" align="right">*</td></tr></table>
                                            </td>
                                            <td height="0">
                                                <table width="70" border="0" cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td width="70">
                                                            <uc1:UserComboBox runat="server" ID="l_from" ListWidth="180" clsClass="select_160px"
                                                                TabIndex="15" Query="option=LocationList&sys=A" StoreID="StoreLocation" Width="67"
                                                                winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=A" winWidth="845"
                                                                winHeight="620" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td align="left" style="padding-left:5px">
                                            <table width="65px"><tr><td align="left">To</td><td class="font_red" align="right">*</td></tr></table>
                                            </td>
                                            <td>
                                                <table border="0" cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td>
                                                            <uc1:UserComboBox runat="server" ID="l_to" ListWidth="180" clsClass="select_160px"
                                                                TabIndex="16" Query="option=LocationList&sys=A" StoreID="StoreLocation" Width="67"
                                                                winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=A" winWidth="845"
                                                                winHeight="620" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td height="25" style="padding-left:3px">
                                            <table  width="50px"><tr><td>ETD</td><td  class="font_red" align="right">*</td></tr></table>
                                            </td>
                                            <td align="left" id="Td1">
                                                <span class="font_11px_gray">
                                                    <ext:DateField ID="l_etd" runat="server" Cls="text" Width="88" Format="dd/m/Y" TabIndex="17">
                                                        <Listeners>
                                                            <%--<Blur Handler="if(#{l_eta}.getValue(true)==''){#{l_eta}.setValue(this.getValue())}" />--%>
                                                            <Blur Handler="#{l_eta}.setValue(this.getValue());" />
                                                        </Listeners>
                                                    </ext:DateField>
                                                </span>
                                            </td>
                                            <td align="left" style="padding-left:5px">
                                            <table width="65px"><tr><td align="left">ETA</td><td class="font_red" align="right">*</td></tr></table>
                                            </td>
                                            <td align="left" id="Td3">
                                                <span class="font_11px_gray">
                                                    <ext:DateField ID="l_eta" runat="server" Cls="text" Width="88" Format="dd/m/Y" TabIndex="18">
                                                        <%-- <Listeners>
                                                        <Change Handler="if(#{l_ata}.getValue(true)==''){#{l_ata}.setValue(this.getValue())}" />
                                                    </Listeners>--%>
                                                    </ext:DateField>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding-left: 6px">
                                                ATD
                                            </td>
                                            <td height="-2" align="left" id="Td4">
                                                <span class="font_11px_gray">
                                                    <ext:DateField ID="l_atd" runat="server" Cls="text" Width="88" Format="dd/m/Y" TabIndex="19">
                                                    </ext:DateField>
                                                </span>
                                            </td>
                                            <td align="left" style="padding-left: 7px">
                                                ATA
                                            </td>
                                            <td align="left" id="Td6">
                                                <span class="font_11px_gray">
                                                    <ext:DateField ID="l_ata" runat="server" Cls="text" Width="88" Format="dd/m/Y" TabIndex="20">
                                                    </ext:DateField>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4" style="padding-top: 10px" align="right">
                                                <table cellpadding="0" cellspacing="0" border="0">
                                                    <tr>
                                                        <td style="padding-right: 3px">
                                                            <table cellpadding="0" cellspacing="0" border="0">
                                                                <tr>
                                                                    <td class="btn_L">
                                                                    </td>
                                                                    <td>
                                                                        <input onclick="InsertFRecord()" type="button" style="cursor: pointer" tabindex="21"
                                                                            value="Save & Next" class="btn_text btn_C" />
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
                                                                        <input onclick="ResetFRecord()" type="button" style="cursor: pointer" tabindex="22"
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
                                                                        <input onclick="DeleteFRecord()" type="button" style="cursor: pointer" tabindex="23"
                                                                            value="Delete" class="btn_text btn_C" />
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
                        </table>
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="2" height="5">
                </td>
            </tr>
            <tr>
                <td valign="top" id="GridView_2">
                    <table cellpadding="0" cellspacing="0" border="0" width="672">
                        <tr>
                            <td class="font_11bold_1542af" style="text-indent: 5px; background-image: url(../../images/bg_line_3.jpg);
                                border-top: 1px solid #8DB2E3; border-left: 1px solid #8DB2E3; border-right: 1px solid #8DB2E3;
                                height: 25px">
                                <div style="float: left; padding-top: 8px;">
                                    HAWB List</div>
                                <div style="float: right; padding-right: 5px;">
                                    <table>
                                        <tr>
                                            <td>
                                                <ext:Button ID="btnPull" runat="server" Text="Pull Back">
                                                    <Listeners>
                                                        <Click Handler="PullBack(#{gpHAWB})" />
                                                    </Listeners>
                                                    <%--<DirectEvents>
                                                    <Click OnEvent="btnPullBack_Click">
                                                    <ExtraParams>
                                                    <ext:Parameter Name="selectHAWBValue" Value="Ext.encode(#{gpHAWB}.getRowsValues({selectedOnly : true}))" Mode="Raw"></ext:Parameter>
                                                    </ExtraParams>
                                                    </Click>
                                                    </DirectEvents>--%>
                                                </ext:Button>
                                            </td>
                                            <td>
                                                <ext:Button ID="btnNew" runat="server" Text="New Shipment" Width="100">
                                                    <Menu>
                                                        <ext:Menu ID="Menu1" runat="server">
                                                            <Items>
                                                                <ext:Button ID="btnShippingNote" Text="New Shipping Note" runat="server" Width="117">
                                                                    <DirectEvents>
                                                                        <Click OnEvent="btnShippingNote_Click">
                                                                            <ExtraParams>
                                                                                <ext:Parameter Name="p_safety_5" Value="Ext.encode(#{gpHAWB}.getRowsValues())" Mode="Raw" />
                                                                            </ExtraParams>
                                                                        </Click>
                                                                    </DirectEvents>
                                                                </ext:Button>
                                                                <ext:Button ID="btnCoLoaderIn" Text="New Co_Loader In" runat="server" Width="117">
                                                                    <DirectEvents>
                                                                        <Click OnEvent="btnCoLoaderIn_Click">
                                                                            <ExtraParams>
                                                                                <ext:Parameter Name="p_safety_5" Value="Ext.encode(#{gpHAWB}.getRowsValues())" Mode="Raw" />
                                                                            </ExtraParams>
                                                                        </Click>
                                                                    </DirectEvents>
                                                                </ext:Button>
                                                                <ext:Button ID="btnCosolManage" Text="Consol Manage" runat="server" Width="117">
                                                                    <DirectEvents>
                                                                        <Click OnEvent="btnCosolManage_Click">
                                                                            <ExtraParams>
                                                                                <ext:Parameter Name="p_safety_5" Value="Ext.encode(#{gpHAWB}.getRowsValues())" Mode="Raw" />
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
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <ext:GridPanel ID="gpHAWB" runat="server" Width="672" Height="131" TrackMouseOver="true"
                                    AllowDomMove="true" ClicksToEdit="1">
                                    <Store>
                                        <ext:Store runat="server" ID="StoreHAWB">
                                            <Reader>
                                                <ext:JsonReader IDProperty="RowID">
                                                    <Fields>
                                                        <ext:RecordField Name="RowID" Type="Int">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Type" Type="String">
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
                                                        <ext:RecordField Name="Done" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="Pallet" Type="String">
                                                        </ext:RecordField>
                                                        <ext:RecordField Name="IsSub" Type="String">
                                                        </ext:RecordField>
                                                    </Fields>
                                                </ext:JsonReader>
                                            </Reader>
                                        </ext:Store>
                                    </Store>
                                    <ColumnModel ID="ColumnModel3">
                                        <Columns>
                                            <ext:DateColumn Header="Est Receipt" DataIndex="EstReceipt" Width="77" Format="dd/MM/yyyy">
                                            </ext:DateColumn>
                                            <ext:Column Header="Shipper" DataIndex="Shipper" Width="105">
                                            </ext:Column>
                                            <ext:Column Header="SN#" DataIndex="SN" Width="135">
                                            </ext:Column>
                                            <ext:Column Header="Dest" DataIndex="DEST" Width="45" Align="Center">
                                            </ext:Column>
                                            <ext:Column Header="HAWB" DataIndex="HAWB" Width="100" Align="Left">
                                            </ext:Column>
                                            <ext:NumberColumn Header="GWT" DataIndex="GWT" Width="55" Format="0.000" Align="Right">
                                            </ext:NumberColumn>
                                            <ext:NumberColumn Header="VWT" DataIndex="VWT" Width="65" Format="0.000" Align="Center"
                                                Hidden="true">
                                            </ext:NumberColumn>
                                            <ext:NumberColumn Header="CWT" DataIndex="CWT" Width="55" Format="0.000" Align="Right">
                                            </ext:NumberColumn>
                                            <ext:NumberColumn Header="Piece" DataIndex="Piece" Width="57" Format="0" Align="Right">
                                            </ext:NumberColumn>
                                            <ext:Column Header="Done" DataIndex="Done" Width="60" Hidden="true">
                                            </ext:Column>
                                        </Columns>
                                    </ColumnModel>
                                    <SelectionModel>
                                        <ext:CheckboxSelectionModel ID="cheka" runat="server">
                                        </ext:CheckboxSelectionModel>
                                    </SelectionModel>
                                </ext:GridPanel>
                            </td>
                        </tr>
                    </table>
                </td>
                <td rowspan="2" valign="top" style="padding-left: 5px">
                    <table width="303px" border="0" align="left" cellpadding="0" cellspacing="0">
                        <tr>
                            <td align="left" valign="top">
                                <table width="303px" height="25" border="0" cellpadding="0" cellspacing="1" bgcolor="8db2e3">
                                    <tr>
                                        <td align="left" background="../../images/bg_line_3.jpg" bgcolor="#FFFFFF" class="font_11bold_1542af"
                                            style="padding-left: 5px">
                                            HAWB Summary
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" valign="top" height="3">
                            </td>
                        </tr>
                        <tr>
                            <td align="left" valign="top">
                                <table border="0" cellpadding="0" cellspacing="1" bgcolor="#8DB2E3" class="table"
                                    width="303px">
                                    <tr>
                                        <td width="60" align="center" bgcolor="#FFFFFF" class="font_11bold">
                                            <table width="60" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td align="center">
                                                        GWT
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="88" align="center" bgcolor="#FFFFFF">
                                            <ext:Label ID="lblGWT" runat="server">
                                            </ext:Label>
                                        </td>
                                        <td width="60" align="center" bgcolor="#FFFFFF" class="font_11bold">
                                            <table width="60" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td align="center">
                                                        Piece(s)
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="88" align="center" bgcolor="#FFFFFF">
                                            <ext:Label ID="lblPiece" runat="server">
                                            </ext:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" bgcolor="#FFFFFF" class="font_11bold">
                                            VWT
                                        </td>
                                        <td align="center" bgcolor="#FFFFFF">
                                            <ext:Label ID="lblVWT" runat="server">
                                            </ext:Label>
                                        </td>
                                        <td align="center" bgcolor="#FFFFFF" class="font_11bold">
                                            &nbsp;
                                        </td>
                                        <td align="center" bgcolor="#FFFFFF">
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" bgcolor="#FFFFFF" class="font_11bold">
                                            CWT
                                        </td>
                                        <td align="center" bgcolor="#FFFFFF">
                                            <ext:Label ID="lblCWT" runat="server">
                                            </ext:Label>
                                        </td>
                                        <td align="center" bgcolor="#FFFFFF" class="font_11bold">
                                            Pallet(s)
                                        </td>
                                        <td align="center" bgcolor="#FFFFFF">
                                            <ext:Label ID="lblPallet" runat="server">
                                            </ext:Label>
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
                <td valign="top" id="GridView_3" >
                    <table cellpadding="0" cellspacing="0" border="0" width="672">
                        <tr>
                            <td class="font_11bold_1542af" style="text-indent: 5px; background-image: url(../../images/bg_line_3.jpg);
                                border-top: 1px solid #8DB2E3; border-left: 1px solid #8DB2E3; border-right: 1px solid #8DB2E3;
                                height: 24px">
                                Local Invoice
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <ext:GridPanel ID="gpInvoice" runat="server" Width="672" Height="131" TrackMouseOver="true"
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
                                            <ext:RowNumbererColumn Header="#" Width="30">
                                            </ext:RowNumbererColumn>
                                            <ext:CheckColumn Header="DN" Width="40" DataIndex="DN" Align="Center">
                                            </ext:CheckColumn>
                                            <ext:CheckColumn Header="CN" Width="40" DataIndex="CN" Align="Center">
                                            </ext:CheckColumn>
                                            <ext:Column Header="DN/CN No." DataIndex="DN_CNNO" Width="140">
                                            </ext:Column>
                                            <ext:Column Header="Company" DataIndex="CompanyName" Width="135">
                                            </ext:Column>
                                            <ext:Column Header="CUR" DataIndex="Currency" Width="70" Align="Center">
                                            </ext:Column>
                                            <ext:NumberColumn Header="Amount" DataIndex="Amount" Width="75" Align="Right">
                                            </ext:NumberColumn>
                                            <ext:CheckColumn Header="Print" DataIndex="Print" Width="40" Align="Center">
                                            </ext:CheckColumn>
                                            <ext:CheckColumn Header="Void" DataIndex="Void" Width="40" Align="Center">
                                            </ext:CheckColumn>
                                            <ext:CheckColumn Header="AC" DataIndex="AC" Width="40" Align="Center">
                                            </ext:CheckColumn>
                                            <%--<ext:ImageCommandColumn Header="Action" Width="50" Align="Center">
                                                <Commands>
                                                    <ext:ImageCommand Icon="BinEmpty" ToolTip-Text="Delete" CommandName="Delete" Style="background-position: center center;
                                                        width: 60px">
                                                        <ToolTip Text="Delete"></ToolTip>
                                                    </ext:ImageCommand>
                                                </Commands>
                                            </ext:ImageCommandColumn>--%>
                                        </Columns>
                                    </ColumnModel>
                                    <%--<Listeners>
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
                <td valign="top" style="padding-left: 5px;">
                    <uc2:UserSheet ID="UserSheet1" runat="server" disHeader="false" isLoad="true" Height="121" />
                </td>
            </tr>
            <tr>
                <td colspan="2" height="5">
                </td>
            </tr>
            <tr>
              <td colspan="2">
              <uc1:Costing ID="ucCost"  runat="server" type="M1"  sys="AE"/>
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
