<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ManifestDetail.aspx.cs" Inherits="AirExport_AEHAWB_ManifestDetail" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<%@ Register Src="../../common/UIControls/AutoComplete.ascx" TagName="AutoComplete"
    TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Manifest Detail</title>
    <link href="../../css/style.css" rel="stylesheet" type="text/css" />

    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>

    <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>

    <script src="../../common/ylQuery/Grid.js" type="text/javascript"></script>

    <script src="../../common/UIControls/CompanyDrpList.js" type="text/javascript"></script>

    <style type="text/css">
        </style>

    <script language="javascript" type="text/javascript">
        function SetInfo(typename, value) {
            var r = StoreCompanyInfo.getById(value);
            var name = typename;
            if (Ext.isEmpty(r)) {
                return;
            }
            if (name == "Shipper") {
                lblShipper1.setText(r.data.co_Name);
                lblShipper2.setText(r.data.co_Address1);
                lblShipper3.setText(r.data.co_Address2);
                lblShipper4.setText(r.data.co_Address3);
                lblShipper5.setText(r.data.co_Address4);
                lblShipper6.setText(r.data.co_Contact);
            }
            else if (name == "Consignee") {
                lblConsignee1.setText(r.data.co_Name);
                lblConsignee2.setText(r.data.co_Address1);
                lblConsignee3.setText(r.data.co_Address2);
                lblConsignee4.setText(r.data.co_Address3);
                lblConsignee5.setText(r.data.co_Address4);
                lblConsignee6.setText(r.data.co_Contact);
            }
            else if (name == "Shipper01") {
                txtShipper1.setValue(r.data.co_Name);
                txtShipper2.setValue(r.data.co_Address1);
                txtShipper3.setValue(r.data.co_Address2);
                txtShipper4.setValue(r.data.co_Address3);
                txtShipper5.setValue(r.data.co_Address4);
                txtShipper6.setValue(r.data.co_Contact);
            }
            else if (name == "Consignee01") {
                txtConsignee1.setValue(r.data.co_Name);
                txtConsignee2.setValue(r.data.co_Address1);
                txtConsignee3.setValue(r.data.co_Address2);
                txtConsignee4.setValue(r.data.co_Address3);
                txtConsignee5.setValue(r.data.co_Address4);
                txtConsignee6.setValue(r.data.co_Contact);
            }
        }

        function DeleteEmpty(grid) {

            if (grid.store.getTotalCount() > 0 && grid.id == "gpHawb") {
                for (var i = 0; i < grid.store.getTotalCount(); ++i) {
                    var data = grid.getRowsValues()[i];
                    var hawb = data.Hawb;

                    if (hawb == "") {
                        grid.getSelectionModel().selectRow(i);
                        grid.deleteSelected();
                    }
                }
            }
        }

        var selectRowIndex = -1;
        function GetRowID(row) {
            selectRowIndex = row;
        }
        function InsertRecord() {
            var HAWB = $("#txtHAWB01").val();
            var PKG = $("#txtPKG01").val();
            var WT = $("#txtWT01").val();
            var Dest = $("#CmbDest01").val();
            var Info = $("#txtInfo01").val();

            var ShipperCode = $("#CmbShipper01").val();
            var Shipper1 = $("#txtShipper1").val();
            var Shipper2 = $("#txtShipper2").val();
            var Shipper3 = $("#txtShipper3").val();
            var Shipper4 = $("#txtShipper4").val();
            var Shipper5 = $("#txtShipper5").val();
            var Shipper6 = $("#txtShipper6").val();

            var ConsigneeCode = $("#CmbConsignee01").val();
            var Consignee1 = $("#txtConsignee1").val();
            var Consignee2 = $("#txtConsignee2").val();
            var Consignee3 = $("#txtConsignee3").val();
            var Consignee4 = $("#txtConsignee4").val();
            var Consignee5 = $("#txtConsignee5").val();
            var Consignee6 = $("#txtConsignee6").val();

            var Nature1 = $("#txtNature1").val();
            var Nature2 = $("#txtNature2").val();
            var Nature3 = $("#txtNature3").val();
            var Nature4 = $("#txtNature4").val();
            var Nature5 = $("#txtNature5").val();
            var Nature6 = $("#txtNature6").val();

            if (HAWB == "" || HAWB == undefined) {
                $("#txtHAWB01").focus();
                return;
            }

            var count = gpHawb.store.getTotalCount();  // 获取当前行数
            if (selectRowIndex >= 0) {
                var record = gpHawb.getStore().getAt(selectRowIndex); // 获取当前行的数据
                record.set("wbm_HAWB", HAWB.toUpperCase());
                record.set("wbm_RCP", PKG);
                record.set("wbm_WT", WT);
                record.set("wbm_Final", Dest);
                record.set("wbm_WTLine", Info);

                record.set("wbm_ShipperCode", ShipperCode);
                record.set("wbm_Shipper1", Shipper1);
                record.set("wbm_Shipper2", Shipper2);
                record.set("wbm_Shipper3", Shipper3);
                record.set("wbm_Shipper4", Shipper4);
                record.set("wbm_Shipper5", Shipper5);
                record.set("wbm_Shipper6", Shipper6);

                record.set("wbm_ConsigneeCode", ConsigneeCode);
                record.set("wbm_Consignee1", Consignee1);
                record.set("wbm_Consignee2", Consignee2);
                record.set("wbm_Consignee3", Consignee3);
                record.set("wbm_Consignee4", Consignee4);
                record.set("wbm_Consignee5", Consignee5);
                record.set("wbm_Consignee6", Consignee6);

                record.set("wbm_Nature1", Nature1);
                record.set("wbm_Nature2", Nature2);
                record.set("wbm_Nature3", Nature3);
                record.set("wbm_Nature4", Nature4);
                record.set("wbm_Nature5", Nature5);
                record.set("wbm_Nature6", Nature6);
            }
            else {
                gpHawb.insertRecord(count, { wbm_HAWB: HAWB.toUpperCase(), wbm_RCP: PKG, wbm_WT: WT, wbm_Final: Dest, wbm_WTLine: Info, wbm_ShipperCode: ShipperCode, wbm_Shipper1: Shipper1, wbm_Shipper2: Shipper2, wbm_Shipper3: Shipper3, wbm_Shipper4: Shipper4, wbm_Shipper5: Shipper5, wbm_Shipper6: Shipper6,
                    wbm_ConsigneeCode: ConsigneeCode, wbm_Consignee1: Consignee1, wbm_Consignee2: Consignee2, wbm_Consignee3: Consignee3, wbm_Consignee4: Consignee4, wbm_Consignee5: Consignee5, wbm_Consignee6: Consignee6, wbm_Nature1: Nature1, wbm_Nature2: Nature2, wbm_Nature3: Nature3, wbm_Nature4: Nature4, wbm_Nature5: Nature5, wbm_Nature6: Nature6
                });
            }
            gpHawb.getView().refresh();
            gpHawb.view.focusEl.focus();
            ResetRecord();

        }
        function SelectRecord() {
            var record = gpHawb.getStore().getAt(selectRowIndex); // 获取当前行的数据
            if (record == null || record == undefined)
                return;
            else {
                $("#txtHAWB01").val(record.data.wbm_HAWB);
                $("#txtPKG01").val(record.data.wbm_RCP);
                $("#txtWT01").val(record.data.wbm_WT);
                $("#CmbDest01").val(record.data.wbm_Final);
                $("#txtInfo01").val(record.data.wbm_WTLine);

                $("#CmbShipper01").val(record.data.wbm_ShipperCode);
                $("#txtShipper1").val(record.data.wbm_Shipper1);
                $("#txtShipper2").val(record.data.wbm_Shipper2);
                $("#txtShipper3").val(record.data.wbm_Shipper3);
                $("#txtShipper4").val(record.data.wbm_Shipper4);
                $("#txtShipper5").val(record.data.wbm_Shipper5);
                $("#txtShipper6").val(record.data.wbm_Shipper6);

                $("#CmbConsignee01").val(record.data.wbm_ConsigneeCode);
                $("#txtConsignee1").val(record.data.wbm_Consignee1);
                $("#txtConsignee2").val(record.data.wbm_Consignee2);
                $("#txtConsignee3").val(record.data.wbm_Consignee3);
                $("#txtConsignee4").val(record.data.wbm_Consignee4);
                $("#txtConsignee5").val(record.data.wbm_Consignee5);
                $("#txtConsignee6").val(record.data.wbm_Consignee6);

                $("#txtNature1").val(record.data.wbm_Nature1);
                $("#txtNature2").val(record.data.wbm_Nature2);
                $("#txtNature3").val(record.data.wbm_Nature3);
                $("#txtNature4").val(record.data.wbm_Nature4);
                $("#txtNature5").val(record.data.wbm_Nature5);
                $("#txtNature6").val(record.data.wbm_Nature6);

            }
        }
        function ResetRecord() {
            selectRowIndex = -1;
            $("#txtHAWB01").val("");
            $("#txtPKG01").val("");
            $("#txtWT01").val("");
            $("#CmbDest01").val("");
            $("#txtInfo01").val("");

            $("#CmbShipper01").val("");
            $("#txtShipper1").val("");
            $("#txtShipper2").val("");
            $("#txtShipper3").val("");
            $("#txtShipper4").val("");
            $("#txtShipper5").val("");
            $("#txtShipper6").val("");

            $("#CmbConsignee01").val("");
            $("#txtConsignee1").val("");
            $("#txtConsignee2").val("");
            $("#txtConsignee3").val("");
            $("#txtConsignee4").val("");
            $("#txtConsignee5").val("");
            $("#txtConsignee6").val("");

            $("#txtNature1").val("");
            $("#txtNature2").val("");
            $("#txtNature3").val("");
            $("#txtNature4").val("");
            $("#txtNature5").val("");
            $("#txtNature6").val("");
            $("#txtHAWB01").focus();

            $("#txtHAWB01").focus();
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager runat="server" ID="ResourceManager" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
    <ext:Hidden ID="hidSeed" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="hidID" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="hidSetInformation" runat="server">
    </ext:Hidden>
    <ext:Store runat="server" ID="StoreCompanyInfo">
        <Reader>
            <ext:JsonReader IDProperty="co_CODE">
                <Fields>
                    <ext:RecordField Name="co_CODE">
                    </ext:RecordField>
                    <ext:RecordField Name="co_Name">
                    </ext:RecordField>
                    <ext:RecordField Name="co_Address1">
                    </ext:RecordField>
                    <ext:RecordField Name="co_Address2">
                    </ext:RecordField>
                    <ext:RecordField Name="co_Address3">
                    </ext:RecordField>
                    <ext:RecordField Name="co_Address4">
                    </ext:RecordField>
                    <ext:RecordField Name="co_Contact">
                    </ext:RecordField>
                </Fields>
            </ext:JsonReader>
        </Reader>
    </ext:Store>
    <ext:Store runat="server" ID="StoreLocation">
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
    <table border="0" cellpadding="0" cellspacing="0" style="padding-left: 5px; padding-top: 5px;
        padding-right: 5px">
        <tr>
            <td colspan="2" valign="middle" class="table_nav1 font_11bold_1542af" style="padding-left: 5px">
                Manifest Detail
            </td>
        </tr>
        <tr>
            <td colspan="2" valign="top" style="padding-top: 5px; padding-left: 5px">
                <table width="740" height="84" border="0" cellpadding="0" cellspacing="2">
                    <tr>
                        <td width="80" height="26" valign="bottom">
                            HAWB NO.
                        </td>
                        <td width="44" height="26">
                            NO. OF
                            <br />
                            PKG.
                        </td>
                        <td width="54">
                            WT. IN
                            <br />
                            KILO(LB)
                        </td>
                        <td width="50" height="26">
                            FINAL
                            <br />
                            DEST
                        </td>
                       <td><table cellpadding="0" cellspacing="0" border="0"><tr> 
                       <td width="90">SHIPPER CODE</td>
                       <td style="padding-left: 15px;">
                            <uc1:AutoComplete runat="server" ID="CmbShipperCode" clsClass="x-form-text x-form-field text_82px"
                                isAlign="false" isDiplay="false" isButton="false" isText="false" Width="109"
                                TabIndex="7" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx"/>
                        </td></tr></table></td>
                       <td><table cellpadding="0" cellspacing="0" border="0"><tr> 
                       <td width="110">CONSIGNEE CODE</td>
                       <td style="padding-left: 2px; padding-right:2px">
                            <uc1:AutoComplete runat="server" ID="CmbConsignee" clsClass="x-form-text x-form-field text_82px"
                                isAlign="false" isDiplay="false" isButton="false" TabIndex="14" isText="false"
                                Width="109" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx" />
                        </td></tr></table></td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td height="25">
                            <ext:TextField ID="txtHAWB" Cls="text_80px" TabIndex="1" runat="server" Width="84"
                                AllowBlank="false">
                            </ext:TextField>
                        </td>
                        <td height="25">
                            <ext:NumberField runat="server" ID="txtPKG" Cls="text_80px" Width="44" DecimalPrecision="1"
                                AllowNegative="false" TabIndex="2" StyleSpec="text-align:right">
                            </ext:NumberField>
                        </td>
                        <td height="25">
                            <ext:NumberField runat="server" ID="txtWT" Cls="text_80px" Width="54" AllowNegative="false"
                                DecimalPrecision="3" TabIndex="3" StyleSpec="text-align:right">
                            </ext:NumberField>
                        </td>
                        <td height="25">
                            <ext:ComboBox ID="CmbDest" runat="server" Cls="select_53" DisplayField="value" TabIndex="4"
                                ForceSelection="true" Mode="Local" StoreID="StoreLocation" TriggerAction="All"
                                ValueField="value" Width="50">
                                <Template Visible="False" ID="ctl1101" StopIDModeInheritance="False" EnableViewState="False">
                                </Template>
                            </ext:ComboBox>
                        </td>
                        <td height="25" style="padding-left: 1px">
                            NAME &amp; ADDRESS OF SHIPPER
                        </td>
                        <td style="padding-left: 1px">
                            NAME &amp; ADDRESS OF CONSIGNEE
                        </td>
                        <td style="padding-left: 1px">
                            COMMODITY / CUSTOMS VALUE
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" valign="top" align="right">
                            <table cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td style="padding-top: 2px" align="right">
                                        <ext:TextField ID="txtInfo" Cls="text_80px" runat="server" Width="152" TabIndex="5">
                                        </ext:TextField>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" style="padding-top: 78px">
                                        <table cellpadding="0" cellspacing="0" border="0">
                                            <tr>
                                                <td align="left" height="26" style="padding-right: 13px">
                                                    PRE-ALERT (VOL)WT.
                                                </td>
                                                <td>
                                                    <ext:NumberField runat="server" ID="txtPreWT" Cls="text_80px" Width="107" AllowNegative="false"
                                                        DecimalPrecision="3" TabIndex="6" StyleSpec="text-align:right">
                                                    </ext:NumberField>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td height="108" valign="top">
                            <table style="line-height: 18px;">
                                <tr>
                                    <td>
                                        <table border="0" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td>
                                                    <ext:TextField runat="server" ID="lblShipper1" Cls="text_80px" Width="200" TabIndex="8" MaxLength="43"  >
                                                    </ext:TextField>
                                                </td>
                                                <td style="padding-left: 2px;">
                                                    <img src="../../images/table/btn.jpg" width="16" onclick="CompanyX.GetHAWBInfo('Shipper')"
                                                        style="cursor: pointer;" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <ext:TextField runat="server" ID="lblShipper2" Cls="text_80px" Width="218" TabIndex="9" MaxLength="43" >
                                        </ext:TextField>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <ext:TextField runat="server" ID="lblShipper3" Cls="text_80px" Width="218" TabIndex="10" MaxLength="43">
                                        </ext:TextField>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <ext:TextField runat="server" ID="lblShipper4" Cls="text_80px" Width="218" TabIndex="11" MaxLength="43">
                                        </ext:TextField>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <ext:TextField runat="server" ID="lblShipper5" Cls="text_80px" Width="218" TabIndex="12" MaxLength="43">
                                        </ext:TextField>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <ext:TextField runat="server" ID="lblShipper6" Cls="text_80px" Width="218" TabIndex="13" MaxLength="43">
                                        </ext:TextField>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td height="25" valign="top">
                            <table style="line-height: 18px;">
                                <tr>
                                    <td>
                                        <table border="0" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td>
                                                    <ext:TextField runat="server" ID="lblConsignee1" Cls="text_80px" Width="200" TabIndex="15" MaxLength="43">
                                                    </ext:TextField>
                                                </td>
                                                <td style="padding-left: 2px;">
                                                    <img src="../../images/table/btn.jpg" width="16" onclick="CompanyX.GetHAWBInfo('Consignee')"
                                                        style="cursor: pointer;" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <ext:TextField runat="server" ID="lblConsignee2" Cls="text_80px" Width="218" TabIndex="16" MaxLength="43">
                                        </ext:TextField>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <ext:TextField runat="server" ID="lblConsignee3" Cls="text_80px" Width="218" TabIndex="17" MaxLength="43">
                                        </ext:TextField>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <ext:TextField runat="server" ID="lblConsignee4" Cls="text_80px" Width="218" TabIndex="18" MaxLength="43">
                                        </ext:TextField>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <ext:TextField runat="server" ID="lblConsignee5" Cls="text_80px" Width="218" TabIndex="19" MaxLength="43">
                                        </ext:TextField>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <ext:TextField runat="server" ID="lblConsignee6" Cls="text_80px" Width="218" TabIndex="20" MaxLength="43">
                                        </ext:TextField>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td height="25" valign="top">
                            <table style="line-height: 18px;">
                                <tr>
                                    <td>
                                        <table border="0" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td>
                                                    <ext:TextField runat="server" ID="lblNature1" Cls="text_80px" Width="200" TabIndex="21" MaxLength="38">
                                                    </ext:TextField>
                                                </td>
                                                <td style="padding-left: 2px;">
                                                    <img src="../../images/table/btn.jpg" width="16" onclick="CompanyX.GetHAWBInfo('Customer')"
                                                        style="cursor: pointer;" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <ext:TextField runat="server" ID="lblNature2" Cls="text_80px" Width="218" TabIndex="22" MaxLength="38">
                                        </ext:TextField>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <ext:TextField runat="server" ID="lblNature3" Cls="text_80px" Width="218" TabIndex="23" MaxLength="38">
                                        </ext:TextField>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <ext:TextField runat="server" ID="lblNature4" Cls="text_80px" Width="218" TabIndex="24" MaxLength="38">
                                        </ext:TextField>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <ext:TextField runat="server" ID="lblNature5" Cls="text_80px" Width="218" TabIndex="25" MaxLength="38">
                                        </ext:TextField>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <ext:TextField runat="server" ID="lblNature6" Cls="text_80px" Width="218" TabIndex="26" MaxLength="38">
                                        </ext:TextField>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="2" valign="top" style="padding-top: 5px">
                <table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" class="table_nav2">
                    <tr>
                        <td class="font_11bold_1542af" style="padding-left: 5px">
                            Under HAWB
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td valign="top" style="padding-left: 5px; padding-top: 4px" align="left">
            </td>
            <td align="left" valign="top" style="padding-top: 4px">
                <table width="740" height="191" border="0" cellpadding="0" cellspacing="2">
                    <tr>
                        <td width="80" height="26" valign="bottom">
                            HAWB NO.
                        </td>
                        <td width="40" height="26" align="left">
                            NO. OF
                            <br />
                            PKG.
                        </td>
                        <td width="55">
                            WT. IN
                            <br />
                            KILO(LB)
                        </td>
                        <td width="50" height="26">
                            FINAL
                            <br />
                            DEST
                        </td>
                        <td><table cellpadding="0" cellspacing="0" border="0"><tr>
                        <td width="90">SHIPPER CODE</td>
                        <td style="padding-left:13px">
                            <uc1:AutoComplete runat="server" ID="CmbShipper01" clsClass="x-form-text x-form-field text_82px"
                                isAlign="false" isDiplay="false" isButton="false" isText="false" Width="109"
                                TabIndex="33" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx" />
                        </td></tr></table></td>
                        <td><table cellpadding="0" cellspacing="0" border="0"><tr><td width="105">CONSIGNEE CODE</td>
                        <td style="padding-right:4px;" >
                            <uc1:AutoComplete runat="server" ID="CmbConsignee01" clsClass="x-form-text x-form-field text_82px"
                                isAlign="false" isDiplay="false" isButton="false" isText="false" Width="109"
                                TabIndex="40" winTitle="Company" winUrl="/BasicData/Customer/detail.aspx" />
                        </td>
                        </tr></table></td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td height="25">
                            <ext:TextField ID="txtHAWB01" Cls="text_80px" runat="server" Width="84" TabIndex="27">
                            </ext:TextField>
                        </td>
                        <td height="25">
                            <ext:NumberField runat="server" ID="txtPKG01" Cls="text_80px" Width="44" AllowNegative="false"
                                DecimalPrecision="1" TabIndex="28" StyleSpec="text-align:right">
                            </ext:NumberField>
                        </td>
                        <td height="25">
                            <ext:NumberField runat="server" ID="txtWT01" Cls="text_80px" Width="53" AllowNegative="false"
                                DecimalPrecision="3" TabIndex="29" StyleSpec="text-align:right">
                            </ext:NumberField>
                        </td>
                        <td height="25">
                            <ext:ComboBox ID="CmbDest01" runat="server" Cls="select_53" DisplayField="value"
                                TabIndex="30" ForceSelection="true" Mode="Local" StoreID="StoreLocation" TriggerAction="All"
                                ValueField="value" Width="48">
                                <Template Visible="False" ID="Template1" StopIDModeInheritance="False" EnableViewState="False">
                                </Template>
                            </ext:ComboBox>
                        </td>
                        <td height="25">
                            NAME &amp; ADDRESS OF SHIPPER
                        </td>
                        <td>
                            NAME &amp; ADDRESS OF CONSIGNEE
                        </td>
                        <td>
                            <table cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td>
                                        COMMODITY / CUSTOMS VALUE
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <td>
                    </td>
                    <td height="22" colspan="3" valign="top">
                        <ext:TextField ID="txtInfo01" Cls="text_80px" runat="server" Width="151" TabIndex="31">
                        </ext:TextField>
                    </td>
                    <td height="11" valign="top">
                        <ext:TextField runat="server" ID="txtShipper1" Cls="text_80px" Width="218" TabIndex="34" MaxLength="43">
                        </ext:TextField>
                    </td>
                    <td height="-4" valign="top">
                        <ext:TextField runat="server" ID="txtConsignee1" Cls="text_80px" Width="218" TabIndex="41" MaxLength="43">
                        </ext:TextField>
                    </td>
                    <td height="-4" valign="top">
                        <ext:TextField runat="server" ID="txtNature1" Cls="text_80px" Width="218" TabIndex="47" MaxLength="38">
                        </ext:TextField>
                    </td>
        </tr>
        <tr>
            <td colspan="4" rowspan="5" valign="top" align="left">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="160" id="GridView">
                            <ext:GridPanel ID="gpHawb" runat="server" Width="160px" Height="90" TrackMouseOver="true"
                                StripeRows="true" ColumnLines="True" ClicksToEdit="1">
                                <Store>
                                    <ext:Store runat="server" ID="storeHawb">
                                        <Reader>
                                            <ext:JsonReader IDProperty="wbm_ROWID">
                                                <Fields>
                                                    <ext:RecordField Name="wbm_ROWID" Type="Int">
                                                    </ext:RecordField>
                                                    <ext:RecordField Name="wbm_HAWB" Type="String">
                                                    </ext:RecordField>
                                                    <ext:RecordField Name="wbm_RCP" Type="String">
                                                    </ext:RecordField>
                                                    <ext:RecordField Name="wbm_WT" Type="String">
                                                    </ext:RecordField>
                                                    <ext:RecordField Name="wbm_Final" Type="String">
                                                    </ext:RecordField>
                                                    <ext:RecordField Name="wbm_WTLine" Type="String">
                                                    </ext:RecordField>
                                                    <ext:RecordField Name="wbm_ShipperCode" Type="String">
                                                    </ext:RecordField>
                                                    <ext:RecordField Name="wbm_Shipper1" Type="String">
                                                    </ext:RecordField>
                                                    <ext:RecordField Name="wbm_Shipper2" Type="String">
                                                    </ext:RecordField>
                                                    <ext:RecordField Name="wbm_Shipper3" Type="String">
                                                    </ext:RecordField>
                                                    <ext:RecordField Name="wbm_Shipper4" Type="String">
                                                    </ext:RecordField>
                                                    <ext:RecordField Name="wbm_Shipper5" Type="String">
                                                    </ext:RecordField>
                                                    <ext:RecordField Name="wbm_Shipper6" Type="String">
                                                    </ext:RecordField>
                                                    <ext:RecordField Name="wbm_ConsigneeCode" Type="String">
                                                    </ext:RecordField>
                                                    <ext:RecordField Name="wbm_Consignee1" Type="String">
                                                    </ext:RecordField>
                                                    <ext:RecordField Name="wbm_Consignee2" Type="String">
                                                    </ext:RecordField>
                                                    <ext:RecordField Name="wbm_Consignee3" Type="String">
                                                    </ext:RecordField>
                                                    <ext:RecordField Name="wbm_Consignee4" Type="String">
                                                    </ext:RecordField>
                                                    <ext:RecordField Name="wbm_Consignee5" Type="String">
                                                    </ext:RecordField>
                                                    <ext:RecordField Name="wbm_Consignee6" Type="String">
                                                    </ext:RecordField>
                                                    <ext:RecordField Name="wbm_Nature1" Type="String">
                                                    </ext:RecordField>
                                                    <ext:RecordField Name="wbm_Nature2" Type="String">
                                                    </ext:RecordField>
                                                    <ext:RecordField Name="wbm_Nature3" Type="String">
                                                    </ext:RecordField>
                                                    <ext:RecordField Name="wbm_Nature4" Type="String">
                                                    </ext:RecordField>
                                                    <ext:RecordField Name="wbm_Nature5" Type="String">
                                                    </ext:RecordField>
                                                    <ext:RecordField Name="wbm_Nature6" Type="String">
                                                    </ext:RecordField>
                                                </Fields>
                                            </ext:JsonReader>
                                        </Reader>
                                    </ext:Store>
                                </Store>
                                <ColumnModel runat="server" ID="ColumnModel5">
                                    <Columns>
                                        <ext:Column Header="HAWB" DataIndex="wbm_HAWB" Width="139" Align="center">
                                            <%--<editor>
                        <ext:TextField ID="txtEditHawb"  runat="server"></ext:TextField>         
                 </editor>--%>
                                        </ext:Column>
                                    </Columns>
                                </ColumnModel>
                                <KeyMap>
                                    <%--      <ext:KeyBinding>
                                            <Keys>
                                                <ext:Key Code="INSERT" />
                                            </Keys>
                                            <Listeners>
                                                <Event Handler="DeleteEmpty(#{gpHawb});InsertRow(#{gpHawb},false,0);" />
                                            </Listeners>
                                        </ext:KeyBinding>--%>
                                    <ext:KeyBinding Ctrl="true">
                                        <Keys>
                                            <ext:Key Code="DELETE" />
                                        </Keys>
                                        <Listeners>
                                            <Event Handler="DeleteRow(#{gpHawb})" />
                                        </Listeners>
                                    </ext:KeyBinding>
                                    <ext:KeyBinding>
                                        <Keys>
                                            <ext:Key Code="ESC" />
                                        </Keys>
                                        <Listeners>
                                            <Event Handler="DeleteRow(#{gpHawb})" />
                                        </Listeners>
                                    </ext:KeyBinding>
                                    <%--<ext:KeyBinding>
                                            <Keys><ext:Key Code="TAB" /></Keys>
                                            <Listeners>
                                                <Event Handler="DeleteEmpty(#{gpHawb});InsertRow(#{gpHawb},true,0);" />
                                            </Listeners>
                                        </ext:KeyBinding>--%>
                                    <%-- <ext:KeyBinding>
                                            <Keys><ext:Key Code="ENTER" /></Keys>
                                            <Listeners><Event Handler="EditRow(#{gpHawb},0)" /></Listeners>
                                        </ext:KeyBinding>--%>
                                </KeyMap>
                                <Listeners>
                                    <%--<Click Handler="NewRow(#{gpHawb},0,0)" />--%>
                                    <RowClick Handler="GetRowID(rowIndex);" />
                                </Listeners>
                                <SelectionModel>
                                    <ext:RowSelectionModel ID="RowSelectionModel5" runat="server">
                                        <Listeners>
                                            <%--<RowSelect Handler="getRowIndex(rowIndex);" />--%>
                                            <RowSelect Handler="GetRowID(rowIndex);SelectRecord();" />
                                        </Listeners>
                                        <%--<DirectEvents>
                <RowSelect OnEvent="RowSelect_Click">
                 <ExtraParams>
                 <ext:Parameter Name="RowID" Value="this.getSelected().id" Mode="Raw"/>
                 </ExtraParams>
                </RowSelect>
                </DirectEvents>--%>
                                    </ext:RowSelectionModel>
                                </SelectionModel>
                            </ext:GridPanel>
                        </td>
                        <td style="padding-top: 5px; padding-left: 3px; padding-right: 17px" valign="bottom">
                            <%--<ext:Button runat="server" ID="addNew" Text="Add New" Cls="Submit_65px" Width="60">
<Listeners>
<Click Handler="DeleteEmpty(#{gpHawb});InsertRecord();" />
</Listeners>
</ext:Button>--%>
                            <input onclick="DeleteEmpty(Ext.getCmp('gpHawb'));InsertRecord();" type="button"
                                style="background-image: url(../../images/btn_save_02.jpg); border: 0px; width: 60px;
                                height: 22px; cursor: pointer" tabindex="32" value="Add New" class="btn_text" />
                        </td>
                    </tr>
                </table>
            </td>
            <td height="12" valign="top">
                <ext:TextField runat="server" ID="txtShipper2" Cls="text_80px" Width="218" TabIndex="35" MaxLength="43">
                </ext:TextField>
            </td>
            <td height="-2" valign="top">
                <ext:TextField runat="server" ID="txtConsignee2" Cls="text_80px" Width="218" TabIndex="42" MaxLength="43">
                </ext:TextField>
            </td>
            <td height="-2" valign="top">
                <ext:TextField runat="server" ID="txtNature2" Cls="text_80px" Width="218" TabIndex="48" MaxLength="38">
                </ext:TextField>
            </td>
        </tr>
        <tr>
            <td height="17" valign="top">
                <ext:TextField runat="server" ID="txtShipper3" Cls="text_80px" Width="218" TabIndex="36" MaxLength="43">
                </ext:TextField>
            </td>
            <td height="-2" valign="top">
                <ext:TextField runat="server" ID="txtConsignee3" Cls="text_80px" Width="218" TabIndex="43" MaxLength="43">
                </ext:TextField>
            </td>
            <td height="-2" valign="top">
                <ext:TextField runat="server" ID="txtNature3" Cls="text_80px" Width="218" TabIndex="49" MaxLength="38">
                </ext:TextField>
            </td>
        </tr>
        <tr>
            <td height="17" valign="top">
                <ext:TextField runat="server" ID="txtShipper4" Cls="text_80px" Width="218" TabIndex="37" MaxLength="43">
                </ext:TextField>
            </td>
            <td height="-1" valign="top">
                <ext:TextField runat="server" ID="txtConsignee4" Cls="text_80px" Width="218" TabIndex="44" MaxLength="43">
                </ext:TextField>
            </td>
            <td height="-1" valign="top">
                <ext:TextField runat="server" ID="txtNature4" Cls="text_80px" Width="218" TabIndex="50" MaxLength="38">
                </ext:TextField>
            </td>
        </tr>
        <tr>
            <td height="17" valign="top">
                <ext:TextField runat="server" ID="txtShipper5" Cls="text_80px" Width="218" TabIndex="38" MaxLength="43">
                </ext:TextField>
            </td>
            <td height="-1" valign="top">
                <ext:TextField runat="server" ID="txtConsignee5" Cls="text_80px" Width="218" TabIndex="45" MaxLength="43">
                </ext:TextField>
            </td>
            <td height="-1" valign="top">
                <ext:TextField runat="server" ID="txtNature5" Cls="text_80px" Width="218" TabIndex="56" MaxLength="38">
                </ext:TextField>
            </td>
        </tr>
        <tr>
            <td height="25" valign="top" style="padding-right: 4px">
                <ext:TextField runat="server" ID="txtShipper6" Cls="text_80px" Width="218" TabIndex="39" MaxLength="43">
                </ext:TextField>
            </td>
            <td height="25" valign="top" style="padding-right: 4px">
                <ext:TextField runat="server" ID="txtConsignee6" Cls="text_80px" Width="218" TabIndex="46" MaxLength="43">
                </ext:TextField>
            </td>
            <td height="25" valign="top">
                <ext:TextField runat="server" ID="txtNature6" Cls="text_80px" Width="218" TabIndex="57" MaxLength="38">
                </ext:TextField>
            </td>
        </tr>
    </table>
    </td> </Tr>
    <tr>
        <td colspan="2" style="padding-right: 4px;" align="right">
            <ext:Button ID="btnSave" Text="OK" runat="server" Width="60">
                <Listeners>
                    <Click Handler="DeleteEmpty(#{gpHawb});InsertRecord();" />
                </Listeners>
                <DirectEvents>
                    <Click OnEvent="btnSave_Click">
                        <EventMask ShowMask="true" Msg=" Saving ... " />
                        <ExtraParams>
                            <ext:Parameter Name="HawbValue" Value="Ext.encode(#{gpHawb}.getRowsValues())" Mode="Raw" />
                        </ExtraParams>
                    </Click>
                </DirectEvents>
            </ext:Button>
        </td>
    </tr>
    </table>
    </form>
</body>
</html>
