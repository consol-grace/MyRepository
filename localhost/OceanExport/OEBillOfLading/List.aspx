<%@ Page Language="C#" AutoEventWireup="true" CodeFile="List.aspx.cs" Inherits="OceanExport_OEBillOfLading_List" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<%@ Register Src="../../common/UIControls/AutoComplete.ascx" TagName="AutoComplete"
    TagPrefix="uc1" %>
<%@ Register Src="../../common/UIControls/UserComboBox.ascx" TagName="UserComboBox"
    TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>OE-HBL</title>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />
    <link href="../../css/AE_HAWB.css" rel="stylesheet" type="text/css" />

    <script src="../../js/AE.js" type="text/javascript"></script>

    <script src="../../js/jquery-1.4.1.js" type="text/javascript"></script>

    <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>

    <script src="../../common/ylQuery/Grid.js" type="text/javascript"></script>

    <script src="../../common/UIControls/CompanyDrpList.js" type="text/javascript"></script>

    <script src="../OEJs/BillOfLoading.js" type="text/javascript"></script>

    <style type="text/css">
        .x-form-text, textarea.x-form-field {
            background-image: none;
            border-color: White;
        }

        .select {
            border-color: #B5B8C8;
            background-image: url("/extjs/resources/images/default/form/text-bg-gif/ext.axd");
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <ext:ResourceManager runat="server" ID="ResourceManager" DirectMethodNamespace="CompanyX">
        </ext:ResourceManager>
        <ext:Hidden ID="hidSeed" runat="server">
        </ext:Hidden>
        <ext:Hidden ID="hidRefresh" runat="server" Text="1">
        </ext:Hidden>
        <ext:Hidden ID="hidRefresh1" runat="server" Text="0">
        </ext:Hidden>
        <ext:Hidden ID="hidChecked" runat="server" Text="">
        </ext:Hidden>
        <ext:Hidden ID="hidDigits" runat="server" Text="1">
        </ext:Hidden>
        <ext:Hidden ID="hidShowDetail" runat="server" Text="0">
        </ext:Hidden>
        <ext:Hidden ID="hidSetInformation" runat="server">
        </ext:Hidden>
        <ext:Hidden ID="hidMLine" runat="server" Text="12">
        </ext:Hidden>
        <ext:Hidden ID="hidPLine" runat="server" Text="11">
        </ext:Hidden>
        <ext:Hidden ID="hidDLine" runat="server" Text="12">
        </ext:Hidden>
        <ext:Hidden ID="hidMakeMLine" runat="server" Text="0">
        </ext:Hidden>
        <ext:Hidden ID="hidMakePLine" runat="server" Text="0">
        </ext:Hidden>
        <ext:Hidden ID="hidMakeDLine" runat="server" Text="0">
        </ext:Hidden>
        <ext:Hidden ID="hidMakeOldMLine" runat="server" Text="-1">
        </ext:Hidden>
        <ext:Hidden ID="hidMakeOldPLine" runat="server" Text="-1">
        </ext:Hidden>
        <ext:Hidden ID="hidMakeOldDLine" runat="server" Text="-1">
        </ext:Hidden>
        <ext:Hidden ID="hidAttach" runat="server" Text="1">
        </ext:Hidden>
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
        <div style="padding-left: 10px; padding-top: 20px; padding-bottom: 20px; width: 973">
            <div id="div_title" style="width: 976px; padding-top: 10px;">
                <div style="padding-left: 7px; border: 1px solid #000000; padding-top: 5px; padding-bottom: 5px">
                    <table width="500" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td align="left">
                                <img id="img_showlist" src="/images/arrows_btn.png" style="cursor: pointer; vertical-align: middle"
                                    alt="View" onclick="createFrom('OEHBL');">
                            </td>
                            <td style="padding-left: 5px" class="font_12px" align="left">
                                <table cellpadding="0" cellspacing="0" border="0" width="180px">
                                    <tr>
                                        <td>OE HBL
                                        </td>
                                        <td width="20px" style="padding-top: 1px"></td>
                                        <td align="left" style="padding-top: 1px" valign="top"></td>
                                    </tr>
                                </table>
                            </td>
                            <td style="padding-left: 320px" align="right">
                                <table border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td style="padding-top: 1px">
                                            <ext:Checkbox ID="chkSurrend" runat="server" Cls="x-form-check-wrap_01">
                                                <Listeners>
                                                    <Check Handler="CompanyX.SetCheckValue('1');" />
                                                </Listeners>
                                            </ext:Checkbox>
                                        </td>
                                        <td style="padding-left: 5px; padding-right: 5px; padding-top: 1px" valign="top">SURRENDERED
                                        </td>
                                        <td style="padding-top: 1px">
                                            <ext:Checkbox ID="chkOriginal" runat="server" Cls="x-form-check-wrap_01">
                                                <Listeners>
                                                    <Check Handler="CompanyX.SetCheckValue('2');" />
                                                </Listeners>
                                            </ext:Checkbox>
                                        </td>
                                        <td style="padding-left: 5px; padding-right: 5px; padding-top: 1px" valign="top">ORIGINAL
                                        </td>
                                        <td style="padding-top: 1px">
                                            <ext:Checkbox ID="chkOF" runat="server" Cls="x-form-check-wrap_01">
                                                <Listeners>
                                                    <Check Handler="CompanyX.SetCheckValue('3');" />
                                                </Listeners>
                                            </ext:Checkbox>
                                        </td>
                                        <td style="padding-left: 5px; padding-right: 5px; padding-top: 1px" valign="top">O/F
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td style="padding-left: 10px">
                                <ext:Button ID="btnPrint" runat="server" Text="Print(HBL)" Cls="font_11px_bold2"
                                    Width="60px" StyleSpec="margin:0px 2px;">
                                    <DirectEvents>
                                        <Click OnEvent="btnPrint_Click">
                                            <EventMask Msg=" Saving... " ShowMask="true" />
                                        </Click>
                                    </DirectEvents>
                                </ext:Button>
                            </td>
                            <td style="padding-left: 2px">
                                <ext:Button ID="btnAttach" runat="server" Text="Attach List" Cls="font_11px_bold2"
                                    StyleSpec="margin:0px 2px;">
                                    <DirectEvents>
                                        <Click OnEvent="btnAttach_Click">
                                        </Click>
                                    </DirectEvents>
                                </ext:Button>
                            </td>
                            <td style="padding-left: 2px">
                                <ext:Button ID="btnExport" runat="server" Text="Export" Cls="font_11px_bold2" Width="65"
                                    Hidden="true" StyleSpec="margin:0px 2px;">
                                    <Menu>
                                        <ext:Menu ID="Menu1" runat="server">
                                            <Items>
                                                <ext:Checkbox ID="chkconsignment" BoxLabel="出口货物托运单" runat="server">
                                                    <Listeners>
                                                        <Check Handler="if(this.checked){chkconsignment.setValue('1')}else{chkconsignment.setValue('0')};" />
                                                    </Listeners>
                                                </ext:Checkbox>
                                                <ext:Checkbox ID="chkOutBox" BoxLabel="门到门做箱清单" runat="server">
                                                    <Listeners>
                                                        <Check Handler="if(this.checked){chkOutBox.setValue('1')}else{chkOutBox.setValue('0')};" />
                                                    </Listeners>
                                                </ext:Checkbox>
                                                <ext:Checkbox ID="chkInBox" BoxLabel="门到门内装箱清单" runat="server">
                                                    <Listeners>
                                                        <Check Handler="if(this.checked){chkInBox.setValue('1')}else{chkInBox.setValue('0')};" />
                                                    </Listeners>
                                                </ext:Checkbox>
                                                <ext:Label ID="lblline" runat="server" Text="-------------------------------------">
                                                </ext:Label>
                                                <ext:Checkbox ID="chkAllReport" BoxLabel="导出所有报表" runat="server">
                                                    <Listeners>
                                                        <Check Handler="if(this.checked){chkAllReport.setValue('1')}else{chkAllReport.setValue('0')};" />
                                                    </Listeners>
                                                </ext:Checkbox>
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:Button>
                            </td>
                            <td>
                                <ext:Button ID="btnOption" runat="server" Text="Options" Cls="font_11px_bold2" Width="65"
                                    StyleSpec="margin:0px 2px;" Hidden="true">
                                    <Menu>
                                        <ext:Menu ID="Menu2" runat="server">
                                            <Items>
                                                <ext:Checkbox ID="chkDigits" BoxLabel="3 Digits" runat="server" Name="chkDig">
                                                    <Listeners>
                                                        <Check Handler="if(this.checked){hidDigits.setValue('1')}else{hidDigits.setValue('0')};CompanyX.MakeDetail();" />
                                                    </Listeners>
                                                </ext:Checkbox>
                                                <ext:Checkbox ID="chkShowAll" BoxLabel="Show All In Attach" runat="server" Name="chkShow">
                                                    <Listeners>
                                                        <Check Handler="if(this.checked){hidShowDetail.setValue('1')}else{hidShowDetail.setValue('0')};CompanyX.MakeDetail();" />
                                                    </Listeners>
                                                </ext:Checkbox>
                                            </Items>
                                        </ext:Menu>
                                    </Menu>
                                </ext:Button>
                            </td>
                            <td width="51" style="padding-left: 2px">
                                <ext:Button ID="btnSave" runat="server" Text="Save" Cls="font_11px_bold2" StyleSpec="margin:0px 2px;">
                                    <Listeners>
                                        <Click Handler="return ReturnNull();" />
                                    </Listeners>
                                    <DirectEvents>
                                        <Click OnEvent="btnSave_Click">
                                            <EventMask Msg=" Saving... " ShowMask="true" Target="Page" />
                                        </Click>
                                    </DirectEvents>
                                </ext:Button>
                            </td>
                        </tr>
                    </table>
                </div>
                <div style="width: 976px">
                    <table cellpadding="0" cellspacing="0" border="0" width="976px" style="border-bottom: 1px solid #000000">
                        <tr>
                            <td align="center" class="font_18px" style="padding-bottom: 15px; padding-top: 15px">COMBINED TRANSPORT BILL OF LADING
                            </td>
                        </tr>
                    </table>
                </div>
                <div style="border-bottom: 1px solid #000000; width: 975px; padding-top: 2px">
                </div>
                <div id="div_title" style="margin-top: 99px; margin-left: 513px">
                    <table cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td width="215" valign="top" class="ae_table" align="left" style="border-right: 1px solid #000000; border-left: 1px solid #000000; padding-left: 5px; padding-top: 3px">LOT NO.:
                            </td>
                            <td width="235" valign="top" class="ae_table" align="left" style="padding-left: 5px; padding-top: 3px">B/L NO.:
                            </td>
                        </tr>
                        <tr>
                            <td align="center" valign="top" style="border-right: 1px solid #000000; border-left: 1px solid #000000; border-bottom: 1px solid #000000; padding-bottom: 2px">
                                <ext:Label ID="lablotno" Cls="text_45" runat="server" StyleSpec="border:none; width:100%; text-align:center;">
                                </ext:Label>
                            </td>
                            <td align="center" valign="top" style="border-bottom: 1px solid #000000">
                                <ext:Label ID="labBLNO" Cls="text_45" runat="server" StyleSpec="border:none; width:100%; text-align:center;">
                                </ext:Label>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div style="width: 975px; padding-top: 82px">
                <table width="975px" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td valign="top" bgcolor="#FFFFFF" style="padding-left: 2px; border-right: 1px solid #000000"
                            class="ae_table">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="64%" style="padding-left: 5px">SHIPPER / EXPORTER
                                    </td>
                                    <td width="36%" style="padding-top: 3px; padding-right: 3px">
                                        <uc1:AutoComplete runat="server" ID="CmbShipperCode" clsClass="text_82px" isAlign="false"
                                            isDiplay="false" isButton="false" isText="false" Width="200" winTitle="Company"
                                            winUrl="/BasicData/Customer/detail.aspx" />
                                        <ext:Hidden ID="CmbShipperCode1" runat="server">
                                        </ext:Hidden>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td colspan="2"></td>
                    </tr>
                    <tr>
                        <td valign="top" bgcolor="#FFFFFF" style="border-right: 1px solid #000000" class="ae_table">
                            <ext:TextField ID="txtShipper1" Cls="text_45" TabIndex="1" runat="server" MaxLength="51"
                                Width="510">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td colspan="2"></td>
                    </tr>
                    <tr>
                        <td valign="top" bgcolor="#FFFFFF" style="border-right: 1px solid #000000" class="ae_table">
                            <ext:TextField ID="txtShipper2" Cls="text_45" TabIndex="2" runat="server" MaxLength="51"
                                Width="510">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td colspan="2" rowspan="7" align="center" valign="middle" bgcolor="#FFFFFF" class="font_18px">CONSOLIDATOR INTERNATIONAL CO.,LTD.
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" bgcolor="#FFFFFF" style="border-right: 1px solid #000000" class="ae_table">
                            <ext:TextField ID="txtShipper3" Cls="text_45" TabIndex="3" runat="server" MaxLength="51"
                                Width="510">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" bgcolor="#FFFFFF" class="ae_table" style="border-right: 1px solid #000000">
                            <ext:TextField ID="txtShipper4" Cls="text_45" TabIndex="4" runat="server" MaxLength="51"
                                Width="510">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" bgcolor="#FFFFFF" class="ae_table" style="border-right: 1px solid #000000; border-top: 1px solid #000000">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="64%" style="padding-left: 5px">CONSIGNEE
                                    </td>
                                    <td width="36%" style="padding-right: 3px; padding-top: 3px">
                                        <uc1:AutoComplete runat="server" ID="CmbConsigneeCode" clsClass="text_82px" isAlign="false"
                                            isDiplay="false" isButton="false" isText="false" Width="200" winTitle="Company"
                                            winUrl="/BasicData/Customer/detail.aspx" />
                                        <ext:Hidden ID="CmbConsigneeCode1" runat="server">
                                        </ext:Hidden>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" bgcolor="#FFFFFF" class="ae_table" style="border-right: 1px solid #000000">
                            <ext:TextField ID="txtConsignee1" Cls="text_45" TabIndex="6" runat="server" MaxLength="51"
                                Width="510">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" bgcolor="#FFFFFF" class="ae_table" style="border-right: 1px solid #000000">
                            <ext:TextField ID="txtConsignee2" Cls="text_45" TabIndex="7" runat="server" MaxLength="51"
                                Width="510">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" bgcolor="#FFFFFF" class="ae_table" style="border-right: 1px solid #000000">
                            <ext:TextField ID="txtConsignee3" Cls="text_45" TabIndex="8" runat="server" MaxLength="51"
                                Width="510">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" bgcolor="#FFFFFF" style="border-right: 1px solid #000000" class="ae_table">
                            <ext:TextField ID="txtConsignee4" Cls="text_45" TabIndex="9" runat="server" MaxLength="51"
                                Width="510">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td colspan="2" align="left" valign="middle" bgcolor="#FFFFFF" style="padding-left: 5px; border-top: 1px solid #000000"
                            class="ae_table">ONWARD INLAND ROUTING
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" bgcolor="#FFFFFF" style="border-right: 1px solid #000000; border-bottom: 1px solid #000000"
                            class="ae_table">
                            <ext:TextField ID="txtConsignee5" Cls="text_45" TabIndex="10" runat="server" MaxLength="51"
                                Width="510">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td colspan="2" align="left" valign="top" bgcolor="#FFFFFF" style="border-bottom: 1px solid #000000"
                            class="ae_table">
                            <ext:TextField ID="txtRouting" Cls="text_45" TabIndex="24" runat="server" MaxLength="45"
                                Width="460">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" bgcolor="#FFFFFF" style="border-right: 1px solid #000000" class="ae_table">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="64%" style="padding-left: 5px">NOTIFY PARTY
                                    </td>
                                    <td width="36%" style="padding-right: 3px; padding-top: 3px">
                                        <uc1:AutoComplete runat="server" ID="CmbParty1" clsClass="text_82px" isAlign="false"
                                            isDiplay="false" isButton="false" isText="false" Width="200" winTitle="Company"
                                            winUrl="/BasicData/Customer/detail.aspx" />
                                        <ext:Hidden ID="CmbParty11" runat="server">
                                        </ext:Hidden>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td align="left" valign="middle" bgcolor="#FFFFFF" style="padding-left: 5px; border-right: 1px solid #000000"
                            class="ae_table">SHIPPER'S REF. NO.
                        </td>
                        <td align="left" valign="middle" bgcolor="#FFFFFF" style="padding-left: 5px;" class="ae_table">NO. OF ORIGINAL B/L
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" bgcolor="#FFFFFF" style="border-right: 1px solid #000000" class="ae_table">
                            <ext:TextField ID="txtPartyA1" Cls="text_45" TabIndex="12" runat="server" Width="510"
                                MaxLength="51">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td align="left" valign="top" bgcolor="#FFFFFF" class="ae_table" style="border-right: 1px solid #000000">
                            <ext:TextField ID="txtRefNo" Cls="text_45" TabIndex="25" runat="server" MaxLength="22"
                                Width="220px">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td align="left" valign="top" bgcolor="#FFFFFF" class="ae_table">
                            <ext:TextField ID="txtOrignBL1" Cls="text_45" TabIndex="26" runat="server" EnableKeyEvents="true"
                                Width="240">
                                <Listeners>
                                    <Focus Handler="over_text(this.id);" />
                                    <Blur Handler="out_text(this.id);GetBLCount();" />
                                    <KeyUp Handler="SetBLCount(event);" />
                                </Listeners>
                            </ext:TextField>
                            <ext:NumberField ID="txtOrignBL" Cls="text_45" runat="server" MaxLength="24" Width="240px"
                                Hidden="true">
                            </ext:NumberField>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" bgcolor="#FFFFFF" style="border-right: 1px solid #000000" class="ae_table">
                            <ext:TextField ID="txtPartyA2" Cls="text_45" TabIndex="13" runat="server" Width="510"
                                MaxLength="51">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td colspan="2" align="left" valign="middle" bgcolor="#FFFFFF" class="ae_table" style="padding-left: 5px; border-top: 1px solid #000000">DOMESTIC ROUTING/EXPORT INSTRUCTIONS
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" bgcolor="#FFFFFF" style="border-right: 1px solid #000000" class="ae_table">
                            <ext:TextField ID="txtPartyA3" Cls="text_45" TabIndex="14" runat="server" Width="510"
                                MaxLength="51">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td colspan="2" align="left" valign="top" bgcolor="#FFFFFF" class="ae_table">
                            <ext:TextField ID="txtInstr1" Cls="text_45" TabIndex="27" runat="server" MaxLength="45"
                                Width="460">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" bgcolor="#FFFFFF" style="border-right: 1px solid #000000" class="ae_table">
                            <ext:TextField ID="txtPartyA4" Cls="text_45" TabIndex="15" runat="server" Width="510"
                                MaxLength="51">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td colspan="2" align="left" valign="top" bgcolor="#FFFFFF" class="ae_table">
                            <ext:TextField ID="txtInstr2" Cls="text_45" TabIndex="28" runat="server" MaxLength="45"
                                Width="460">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" bgcolor="#FFFFFF" style="border-right: 1px solid #000000" class="ae_table">
                            <ext:TextField ID="txtPartyA5" Cls="text_45" TabIndex="16" runat="server" Width="510"
                                MaxLength="51">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td colspan="2" align="left" valign="top" bgcolor="#FFFFFF" class="ae_table">
                            <ext:TextField ID="txtInstr3" Cls="text_45" TabIndex="29" runat="server" MaxLength="45"
                                Width="460">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" bgcolor="#FFFFFF" style="border-right: 1px solid #000000; border-top: 1px solid #000000"
                            class="ae_table">
                            <table width="510" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="255" style="border-right: 1px solid #000000; padding-top: 7px; padding-bottom: 2px; padding-left: 5px">
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td>PLACE OF RECEIPT
                                                </td>
                                                <td align="right" style="padding-right: 3px;">
                                                    <uc1:UserComboBox runat="server" ID="CmbReceipt" ListWidth="180" clsClass="select_160px"
                                                        TabIndex="300" StoreID="StoreLocation" Width="87" winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=O"
                                                        winWidth="845" winHeight="620" Handler="SelectItem('CmbReceipt','txtReceipt')"
                                                        Style="border-color: #B5B8C8;" isButton="false" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td width="255" style="padding-left: 5px; padding-top: 5px; padding-bottom: 3px">
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td>PRE-CARRIAGE
                                                </td>
                                                <td style="padding-left: 2px; border-bottom: 1px solid #000000; border-left: 1px solid #000000" class="ae_table">
                                                    <ext:TextField ID="txtPreVoyage" Cls="text_45" TabIndex="18" runat="server" MaxLength="20" ReadOnly="true" 
                                                        Width="118">
                                                        <Listeners>
                                                <Focus Handler="over_text(this.id)" />
                                                <Blur Handler="out_text(this.id)" />
                                            </Listeners>
                                                    </ext:TextField>
                                                    <ext:Checkbox ID="chkRefreshHeader" runat="server" BoxLabel="Refresh Data" Hidden="true">
                                                        <Listeners>
                                                            <Check Handler="if(this.checked){hidRefresh1.setValue('1')}else{hidRefresh1.setValue('0')};CompanyX.MakeHeader();" />
                                                        </Listeners>
                                                    </ext:Checkbox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="ae_table" style="border-right: 1px solid #000000">
                                        <ext:TextField ID="txtReceipt" Cls="text_45" TabIndex="17" runat="server" MaxLength="29"
                                            Width="300">
                                            <Listeners>
                                                <Focus Handler="over_text(this.id)" />
                                                <Blur Handler="out_text(this.id)" />
                                            </Listeners>
                                        </ext:TextField>
                                    </td>
                                    <td class="ae_table" style="padding-left: 2px">
                                        <ext:TextField ID="txtCarriage" Cls="text_45" TabIndex="18" runat="server" MaxLength="30" ReadOnly="true"
                                            Width="210">
                                            <Listeners>
                                                <Focus Handler="over_text(this.id)" />
                                                <Blur Handler="out_text(this.id)" />
                                            </Listeners>
                                        </ext:TextField>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td colspan="2" rowspan="6" align="left" valign="top" bgcolor="#FFFFFF" class="ae_table"
                            style="border-top: 1px solid #000000">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td>
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td valign="middle" style="padding-left: 5px; padding-top: 3px">TO OBTAIN DELIVERY PLEASE CONTACT:
                                                </td>
                                                <td style="padding-right: 3px; padding-top: 3px">
                                                    <uc1:AutoComplete runat="server" ID="CmbContact" clsClass="text_82px" isAlign="false"
                                                        isDiplay="false" isButton="false" isText="false" Width="200" winTitle="Company"
                                                        winUrl="/BasicData/Customer/detail.aspx" />
                                                    <ext:Hidden ID="CmbContact1" runat="server">
                                                    </ext:Hidden>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="ae_table" style="padding-top: 1px">
                                        <ext:TextField ID="txtContact1" Cls="text_45" TabIndex="30" runat="server" MaxLength="45"
                                            Width="460">
                                            <Listeners>
                                                <Focus Handler="over_text(this.id)" />
                                                <Blur Handler="out_text(this.id)" />
                                            </Listeners>
                                        </ext:TextField>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="ae_table" style="padding-top: 1px">
                                        <ext:TextField ID="txtContact2" Cls="text_45" TabIndex="31" runat="server" MaxLength="45"
                                            Width="460">
                                            <Listeners>
                                                <Focus Handler="over_text(this.id)" />
                                                <Blur Handler="out_text(this.id)" />
                                            </Listeners>
                                        </ext:TextField>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="ae_table">
                                        <ext:TextField ID="txtContact3" Cls="text_45" TabIndex="32" runat="server" MaxLength="45"
                                            Width="460">
                                            <Listeners>
                                                <Focus Handler="over_text(this.id)" />
                                                <Blur Handler="out_text(this.id)" />
                                            </Listeners>
                                        </ext:TextField>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="ae_table">
                                        <ext:TextField ID="txtContact4" Cls="text_45" TabIndex="33" runat="server" MaxLength="45"
                                            Width="460">
                                            <Listeners>
                                                <Focus Handler="over_text(this.id)" />
                                                <Blur Handler="out_text(this.id)" />
                                            </Listeners>
                                        </ext:TextField>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="ae_table">
                                        <ext:TextField ID="txtContact5" Cls="text_45" TabIndex="34" runat="server" MaxLength="45"
                                            Width="460">
                                            <Listeners>
                                                <Focus Handler="over_text(this.id)" />
                                                <Blur Handler="out_text(this.id)" />
                                            </Listeners>
                                        </ext:TextField>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" bgcolor="#FFFFFF" style="border-right: 1px solid #000000; border-top: 1px solid #000000"
                            class="ae_table">
                            <table width="510" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td style="border-right: 1px solid #000000; padding-left: 5px">VESSEL/VOYAGE
                                    </td>
                                    <td style="padding-left: 2px; border-bottom: 1px solid #000000; border-right: 1px solid #000000"
                                        class="ae_table">
                                        <ext:TextField ID="txtVoyage" Cls="text_45" TabIndex="19" runat="server" MaxLength="20" ReadOnly="true"
                                            Width="200">
                                            <Listeners>
                                                <Focus Handler="over_text(this.id)" />
                                                <Blur Handler="out_text(this.id)" />
                                            </Listeners>
                                        </ext:TextField>
                                    </td>
                                    <td width="219" style="padding-left: 5px">
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td>PORT OF LOADING
                                                </td>
                                                <td align="right" style="padding-right: 3px">
                                                    <uc1:UserComboBox runat="server" ID="CmbLoading" ListWidth="180" clsClass="select_160px"
                                                        TabIndex="301" StoreID="StoreLocation" Width="87" winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=O"
                                                        winWidth="845" winHeight="620" Handler="SelectItem('CmbLoading','txtLoading')"
                                                        Style="border-color: #B5B8C8;" isButton="false" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" class="ae_table" style="border-right: 1px solid #000000">
                                        <ext:TextField ID="txtVessel" Cls="text_45" TabIndex="20" runat="server" MaxLength="30" ReadOnly="true"
                                            Width="300">
                                            <Listeners>
                                                <Focus Handler="over_text(this.id)" />
                                                <Blur Handler="out_text(this.id)" />
                                            </Listeners>
                                        </ext:TextField>
                                    </td>
                                    <td class="ae_table" style="padding-left: 2px">
                                        <ext:TextField ID="txtLoading" Cls="text_45" TabIndex="21" runat="server" MaxLength="21" 
                                            Width="210">
                                            <Listeners>
                                                <Focus Handler="over_text(this.id)" />
                                                <Blur Handler="out_text(this.id)" />
                                            </Listeners>
                                        </ext:TextField>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" bgcolor="#FFFFFF" style="border-right: 1px solid #000000; border-top: 1px solid #000000"
                            class="ae_table">
                            <table width="510" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="255" style="border-right: 1px solid #000000; padding-top: 4px; padding-left: 5px">
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td>PORT OF DISCHARGE
                                                </td>
                                                <td align="right" style="padding-right: 3px;">
                                                    <uc1:UserComboBox runat="server" ID="CmbDischarge" ListWidth="180" clsClass="select_160px"
                                                        TabIndex="302" StoreID="StoreLocation" Width="87" winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=O"
                                                        winWidth="845" winHeight="620" Handler="SelectItem('CmbDischarge','txtDischarge')"
                                                        Style="border-color: #B5B8C8;" isButton="false" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td width="255" style="padding-left: 5px; padding-top: 4px">
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td>PLACE OF DELIVERY
                                                </td>
                                                <td align="right" style="padding-right: 3px;">
                                                    <uc1:UserComboBox runat="server" ID="CmbDelivery" ListWidth="180" clsClass="select_160px"
                                                        TabIndex="303" StoreID="StoreLocation" Width="87" winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys=O"
                                                        winWidth="845" winHeight="620" Handler="SelectItem('CmbDelivery','txtDelivery')"
                                                        Style="border-color: #B5B8C8;" isButton="false" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="ae_table" style="border-right: 1px solid #000000">
                                        <ext:TextField ID="txtDischarge" Cls="text_45" TabIndex="22" runat="server" MaxLength="29"
                                            Width="300">
                                            <Listeners>
                                                <Focus Handler="over_text(this.id)" />
                                                <Blur Handler="out_text(this.id)" />
                                            </Listeners>
                                        </ext:TextField>
                                    </td>
                                    <td class="ae_table" style="padding-left: 2px">
                                        <ext:TextField ID="txtDelivery" Cls="text_45" TabIndex="23" runat="server" MaxLength="21"
                                            Width="210">
                                            <Listeners>
                                                <Focus Handler="over_text(this.id)" />
                                                <Blur Handler="out_text(this.id)" />
                                            </Listeners>
                                        </ext:TextField>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
            <div style="border-top: 1px solid #000000; width: 975px;">
                <table cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td colspan="6" valign="middle" class="ae_table" style="text-align: right">
                            <table width="100%">
                                <tr>
                                    <td align="center">PARTICULARS FURNISHED BY SHIPPER
                                    </td>
                                    <td style="width: 95px;" align="right">
                                        <%--<ext:Button ID="btnRefresh" runat="server" Text="Refresh" Cls="font_11px_bold2" StyleSpec="margin:0px 2px;" Hidden="true">
                                            <DirectEvents>
                                                <Click OnEvent="btnRefresh_Click">
                                                <EventMask  Msg=" Loading " ShowMask="true"/>
                                                </Click>
                                            </DirectEvents>
                                        </ext:Button>--%>
                                        <ext:Checkbox ID="chkAutorefresh" runat="server" BoxLabel="Refresh Data">
                                            <Listeners>
                                                <Check Handler="if(this.checked){hidRefresh.setValue('1')}else{hidRefresh.setValue('0')};CompanyX.MakeDetail();" />
                                            </Listeners>
                                        </ext:Checkbox>
                                    </td>
                                    <td style="width: 68px;">
                                        <ext:Checkbox ID="chkDigits1" BoxLabel="3 Digits" runat="server" Name="chkDig">
                                            <Listeners>
                                                <Check Handler="if(this.checked){hidDigits.setValue('1')}else{hidDigits.setValue('0')};CompanyX.MakeDetail();" />
                                            </Listeners>
                                        </ext:Checkbox>
                                    </td>
                                    <td style="width: 125px;">
                                        <ext:Checkbox ID="chkShowAll1" BoxLabel="Show All In Attach" runat="server" Name="chkShow">
                                            <Listeners>
                                                <Check Handler="if(this.checked){hidShowDetail.setValue('1')}else{hidShowDetail.setValue('0')};CompanyX.MakeDetail();" />
                                            </Listeners>
                                        </ext:Checkbox>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td width="191" height="28" align="center" valign="middle" class="ae_table" style="border-top: 1px solid #000000; border-bottom: 1px solid #000000; border-right: 1px solid #000000">MARKS AND MUMBERS<br />
                            CONTAINER &amp; SEAL NO.
                        <br />
                        </td>
                        <td width="101" align="center" valign="middle" class="ae_table" style="border-top: 1px solid #000000; border-bottom: 1px solid #000000; border-right: 1px solid #000000">NO. OF PKGS.
                        </td>
                        <td width="461" align="center" valign="middle" class="ae_table" style="border-top: 1px solid #000000; border-right: 1px solid #000000; border-bottom: 1px solid #000000">DESCRIPTION OF PACKAGES AND GOODS
                        </td>
                        <td width="111" align="center" valign="middle" class="ae_table" style="border-top: 1px solid #000000; border-right: 1px solid #000000; border-bottom: 1px solid #000000">GROSS WEIGHT
                        </td>
                        <td colspan="2" width="109" align="center" valign="middle" class="ae_table" style="border-top: 1px solid #000000; border-bottom: 1px solid #000000">MEASUREMENT
                        </td>
                    </tr>
                    <tr>
                        <td class="ae_table" style="border-right: 1px solid #000000">
                            <ext:TextField ID="txtMarks1" Cls="text_45" runat="server" MaxLength="19" TabIndex="35"
                                Width="190">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td class="ae_table" style="border-right: 1px solid #000000">
                            <ext:TextField ID="txtPKGS1" Cls="text_45" runat="server" MaxLength="10" TabIndex="36"
                                Width="100">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td class="ae_table" style="border-right: 1px solid #000000;">
                            <ext:TextField ID="txtDes1" Cls="text_45" runat="server" MaxLength="46" TabIndex="37"
                                Width="460">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td class="ae_table" style="border-right: 1px solid #000000">
                            <ext:TextField ID="txtGW" Cls="text_45" runat="server" TabIndex="38" Width="100"
                                EnableKeyEvents="true" StyleSpec="text-align:right;">
                                <%--<Listeners>
                                        <Focus Handler="over_text(this.id);" />
                                        <Blur Handler="KeyNumberLeave(this.id,2);out_text(this.id);" />
                                        <KeyUp Handler="KeyNumber(event,this.id);" />
                                    </Listeners>--%>
                            </ext:TextField>
                        </td>
                        <td class="ae_table">
                            <ext:TextField ID="txtMea" Cls="text_45" runat="server" TabIndex="39" Width="80"
                                EnableKeyEvents="true" StyleSpec="text-align:right;">
                                <%--<Listeners>
                                        <Focus Handler="over_text(this.id)" />
                                        <Blur Handler="KeyNumberLeave(this.id,3);out_text(this.id);" />
                                        <KeyUp Handler="KeyNumber(event,this.id);" />
                                    </Listeners>--%>
                            </ext:TextField>
                        </td>
                        <td class="font_10_gray">01
                        </td>
                    </tr>
                    <tr>
                        <td class="ae_table" style="border-right: 1px solid #000000">
                            <ext:TextField ID="txtMarks2" Cls="text_45" runat="server" MaxLength="19" TabIndex="40"
                                Width="190">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td class="ae_table" style="border-right: 1px solid #000000">
                            <ext:TextField ID="txtPKGS2" Cls="text_45" runat="server" MaxLength="10" TabIndex="41"
                                Width="100">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td colspan="3" background="../../images/table/OE_line_01.jpg" class="ae_table line_bg">
                            <ext:TextField ID="txtDes2" Cls="text_45" runat="server" MaxLength="67" TabIndex="42"
                                Width="670">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td class="font_10_gray">02
                        </td>
                    </tr>
                    <tr>
                        <td class="ae_table" style="border-right: 1px solid #000000">
                            <ext:TextField ID="txtMarks3" Cls="text_45" runat="server" MaxLength="19" TabIndex="43"
                                Width="190">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td class="ae_table" style="border-right: 1px solid #000000">
                            <ext:TextField ID="txtPKGS3" Cls="text_45" runat="server" MaxLength="10" TabIndex="44"
                                Width="100">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td colspan="3" background="../../images/table/OE_line_01.jpg" class="ae_table line_bg">
                            <ext:TextField ID="txtDes3" Cls="text_45" runat="server" MaxLength="67" TabIndex="45"
                                Width="670">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td class="font_10_gray">03
                        </td>
                    </tr>
                    <tr>
                        <td class="ae_table" style="border-right: 1px solid #000000">
                            <ext:TextField ID="txtMarks4" Cls="text_45" runat="server" MaxLength="19" TabIndex="46"
                                Width="190">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td class="ae_table" style="border-right: 1px solid #000000">
                            <ext:TextField ID="txtPKGS4" Cls="text_45" runat="server" MaxLength="10" TabIndex="47"
                                Width="100">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td colspan="3" background="../../images/table/OE_line_01.jpg" class="ae_table line_bg">
                            <ext:TextField ID="txtDes4" Cls="text_45" runat="server" MaxLength="67" TabIndex="48"
                                Width="670">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td class="font_10_gray">04
                        </td>
                    </tr>
                    <tr>
                        <td class="ae_table" style="border-right: 1px solid #000000">
                            <ext:TextField ID="txtMarks5" Cls="text_45" runat="server" MaxLength="19" TabIndex="49"
                                Width="190">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td class="ae_table" style="border-right: 1px solid #000000">
                            <ext:TextField ID="txtPKGS5" Cls="text_45" runat="server" MaxLength="10" TabIndex="50"
                                Width="100">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td colspan="3" background="../../images/table/OE_line_01.jpg" class="ae_table line_bg">
                            <ext:TextField ID="txtDes5" Cls="text_45" runat="server" MaxLength="67" TabIndex="51"
                                Width="670">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td class="font_10_gray">05
                        </td>
                    </tr>
                    <tr>
                        <td class="ae_table" style="border-right: 1px solid #000000">
                            <ext:TextField ID="txtMarks6" Cls="text_45" runat="server" MaxLength="19" TabIndex="52"
                                Width="190">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td class="ae_table" style="border-right: 1px solid #000000">
                            <ext:TextField ID="txtPKGS6" Cls="text_45" runat="server" MaxLength="10" TabIndex="53"
                                Width="100">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td colspan="3" background="../../images/table/OE_line_01.jpg" class="ae_table line_bg">
                            <ext:TextField ID="txtDes6" Cls="text_45" runat="server" MaxLength="67" TabIndex="54"
                                Width="670">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td class="font_10_gray">06
                        </td>
                    </tr>
                    <tr>
                        <td class="ae_table" style="border-right: 1px solid #000000">
                            <ext:TextField ID="txtMarks7" Cls="text_45" runat="server" MaxLength="19" TabIndex="55"
                                Width="190">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td class="ae_table" style="border-right: 1px solid #000000">
                            <ext:TextField ID="txtPKGS7" Cls="text_45" runat="server" MaxLength="10" TabIndex="56"
                                Width="100">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td colspan="3" background="../../images/table/OE_line_01.jpg" class="ae_table line_bg">
                            <ext:TextField ID="txtDes7" Cls="text_45" runat="server" MaxLength="67" TabIndex="57"
                                Width="670">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td class="font_10_gray">07
                        </td>
                    </tr>
                    <tr>
                        <td class="ae_table" style="border-right: 1px solid #000000">
                            <ext:TextField ID="txtMarks8" Cls="text_45" runat="server" MaxLength="19" TabIndex="58"
                                Width="190">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td class="ae_table" style="border-right: 1px solid #000000">
                            <ext:TextField ID="txtPKGS8" Cls="text_45" runat="server" MaxLength="10" TabIndex="59"
                                Width="100">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td colspan="3" background="../../images/table/OE_line_01.jpg" class="ae_table line_bg">
                            <ext:TextField ID="txtDes8" Cls="text_45" runat="server" MaxLength="67" TabIndex="60"
                                Width="670">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td class="font_10_gray">08
                        </td>
                    </tr>
                    <tr>
                        <td class="ae_table" style="border-right: 1px solid #000000">
                            <ext:TextField ID="txtMarks9" Cls="text_45" runat="server" MaxLength="19" TabIndex="61"
                                Width="190">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td class="ae_table" style="border-right: 1px solid #000000">
                            <ext:TextField ID="txtPKGS9" Cls="text_45" runat="server" MaxLength="10" TabIndex="62"
                                Width="100">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td colspan="3" background="../../images/table/OE_line_01.jpg" class="ae_table line_bg">
                            <ext:TextField ID="txtDes9" Cls="text_45" runat="server" MaxLength="67" TabIndex="63"
                                Width="670">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td class="font_10_gray">09
                        </td>
                    </tr>
                    <tr>
                        <td class="ae_table" style="border-right: 1px solid #000000">
                            <ext:TextField ID="txtMarks10" Cls="text_45" runat="server" MaxLength="19" TabIndex="64"
                                Width="190">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td class="ae_table" style="border-right: 1px solid #000000">
                            <ext:TextField ID="txtPKGS10" Cls="text_45" runat="server" MaxLength="10" TabIndex="65"
                                Width="100">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td colspan="3" background="../../images/table/OE_line_01.jpg" class="ae_table line_bg">
                            <ext:TextField ID="txtDes10" Cls="text_45" runat="server" MaxLength="67" TabIndex="66"
                                Width="670">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td class="font_10_gray">10
                        </td>
                    </tr>
                    <tr>
                        <td class="ae_table" style="border-right: 1px solid #000000">
                            <ext:TextField ID="txtMarks11" Cls="text_45" runat="server" MaxLength="19" TabIndex="67"
                                Width="190">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td class="ae_table" style="border-right: 1px solid #000000">
                            <ext:TextField ID="txtPKGS11" Cls="text_45" runat="server" MaxLength="10" TabIndex="68"
                                Width="100">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td colspan="3" background="../../images/table/OE_line_01.jpg" class="ae_table line_bg">
                            <ext:TextField ID="txtDes11" Cls="text_45" runat="server" MaxLength="67" TabIndex="69"
                                Width="670">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td class="font_10_gray">11
                        </td>
                    </tr>
                    <tr>
                        <td class="ae_table" style="border-right: 1px solid #000000">
                            <ext:TextField ID="txtMarks12" Cls="text_45" runat="server" MaxLength="19" TabIndex="70"
                                Width="190">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td class="ae_table" style="border-right: 1px solid #000000">
                            <ext:TextField ID="txtPKGS12" Cls="text_45" runat="server" MaxLength="10" TabIndex="71"
                                Width="100">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td colspan="3" background="../../images/table/OE_line_01.jpg" class="ae_table line_bg">
                            <ext:TextField ID="txtDes12" Cls="text_45" runat="server" MaxLength="67" TabIndex="72"
                                Width="670">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td class="font_10_gray">12
                        </td>
                    </tr>
                    <tr>
                        <td class="ae_table" style="border-right: 1px solid #000000">
                            <ext:TextField ID="txtMarks13" Cls="text_45" runat="server" MaxLength="19" TabIndex="73"
                                Width="190">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td class="ae_table" style="border-right: 1px solid #000000">
                            <ext:TextField ID="txtPKGS13" Cls="text_45" runat="server" MaxLength="10" TabIndex="74"
                                Width="100">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td colspan="3" background="../../images/table/OE_line_01.jpg" class="ae_table line_bg">
                            <ext:TextField ID="txtDes13" Cls="text_45" runat="server" MaxLength="67" TabIndex="75"
                                Width="670">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td class="font_10_gray">13
                        </td>
                    </tr>
                    <tr>
                        <td class="ae_table" style="border-right: 1px solid #000000">
                            <ext:TextField ID="txtMarks14" Cls="text_45" runat="server" MaxLength="19" TabIndex="76"
                                Width="190">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td class="ae_table" style="border-right: 1px solid #000000">
                            <ext:TextField ID="txtPKGS14" Cls="text_45" runat="server" MaxLength="10" TabIndex="77"
                                Width="100">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td colspan="3" background="../../images/table/OE_line_01.jpg" class="ae_table line_bg">
                            <ext:TextField ID="txtDes14" Cls="text_45" runat="server" MaxLength="67" TabIndex="78"
                                Width="670">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td class="font_10_gray">14
                        </td>
                    </tr>
                    <tr>
                        <td class="ae_table" style="border-right: 1px solid #000000">
                            <ext:TextField ID="txtMarks15" Cls="text_45" runat="server" MaxLength="19" TabIndex="79"
                                Width="190">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td class="ae_table" style="border-right: 1px solid #000000">
                            <ext:TextField ID="txtPKGS15" Cls="text_45" runat="server" MaxLength="10" TabIndex="80"
                                Width="100">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td colspan="3" background="../../images/table/OE_line_01.jpg" class="ae_table line_bg">
                            <ext:TextField ID="txtDes15" Cls="text_45" runat="server" MaxLength="67" TabIndex="81"
                                Width="670">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td class="font_10_gray">15
                        </td>
                    </tr>
                    <tr>
                        <td class="ae_table" style="border-right: 1px solid #000000">
                            <ext:TextField ID="txtMarks16" Cls="text_45" runat="server" MaxLength="19" TabIndex="82"
                                Width="190">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td class="ae_table" style="border-right: 1px solid #000000">
                            <ext:TextField ID="txtPKGS16" Cls="text_45" runat="server" MaxLength="10" TabIndex="83"
                                Width="100">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td colspan="3" background="../../images/table/OE_line_01.jpg" class="ae_table line_bg">
                            <ext:TextField ID="txtDes16" Cls="text_45" runat="server" MaxLength="67" TabIndex="84"
                                Width="670">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td class="font_10_gray">16
                        </td>
                    </tr>
                    <tr>
                        <td class="ae_table" style="border-right: 1px solid #000000">
                            <ext:TextField ID="txtMarks17" Cls="text_45" runat="server" MaxLength="19" TabIndex="85"
                                Width="190">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td class="ae_table" style="border-right: 1px solid #000000">
                            <ext:TextField ID="txtPKGS17" Cls="text_45" runat="server" MaxLength="10" TabIndex="86"
                                Width="100">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td colspan="3" background="../../images/table/OE_line_01.jpg" class="ae_table line_bg">
                            <ext:TextField ID="txtDes17" Cls="text_45" runat="server" MaxLength="67" TabIndex="87"
                                Width="670">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td class="font_10_gray">17
                        </td>
                    </tr>
                    <tr>
                        <td class="ae_table" style="border-right: 1px solid #000000">
                            <ext:TextField ID="txtMarks18" Cls="text_45" runat="server" MaxLength="19" TabIndex="88"
                                Width="190">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td class="ae_table" style="border-right: 1px solid #000000">
                            <ext:TextField ID="txtPKGS18" Cls="text_45" runat="server" MaxLength="10" TabIndex="89"
                                Width="100">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td colspan="3" background="../../images/table/OE_line_01.jpg" class="ae_table line_bg">
                            <ext:TextField ID="txtDes18" Cls="text_45" runat="server" MaxLength="67" TabIndex="90"
                                Width="670">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td class="font_10_gray">18
                        </td>
                    </tr>
                    <tr>
                        <td class="ae_table" style="border-right: 1px solid #000000">
                            <ext:TextField ID="txtMarks19" Cls="text_45" runat="server" MaxLength="19" TabIndex="91"
                                Width="190">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td class="ae_table" style="border-right: 1px solid #000000">
                            <ext:TextField ID="txtPKGS19" Cls="text_45" runat="server" MaxLength="10" TabIndex="92"
                                Width="100">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td colspan="3" background="../../images/table/OE_line_01.jpg" class="ae_table line_bg">
                            <ext:TextField ID="txtDes19" StyleSpec="text-align:center" Cls="text_45" runat="server"
                                MaxLength="67" TabIndex="93" Width="670">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td class="font_10_gray">19
                        </td>
                    </tr>
                    <tr>
                        <td class="ae_table" style="border-right: 1px solid #000000">
                            <ext:TextField ID="txtMarks20" Cls="text_45" runat="server" MaxLength="19" TabIndex="94"
                                Width="190">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td class="ae_table" style="border-right: 1px solid #000000">
                            <ext:TextField ID="txtPKGS20" Cls="text_45" runat="server" MaxLength="10" TabIndex="95"
                                Width="100">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td colspan="3" background="../../images/table/OE_line_01.jpg" class="ae_table line_bg">
                            <ext:TextField ID="txtDes20" Cls="text_45" runat="server" MaxLength="67" TabIndex="96"
                                Width="670">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td class="font_10_gray">20
                        </td>
                    </tr>
                    <tr>
                        <td class="ae_table" style="border-bottom: 1px solid #000000; border-right: 1px solid #000000">
                            <ext:TextField ID="txtMarks21" Cls="text_45" runat="server" MaxLength="19" TabIndex="97"
                                Width="190">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td class="ae_table" style="border-bottom: 1px solid #000000; border-right: 1px solid #000000">
                            <ext:TextField ID="txtPKGS21" Cls="text_45" runat="server" MaxLength="10" TabIndex="98"
                                Width="100">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td colspan="3" background="../../images/table/OE_line_01.jpg" class="ae_table line_bg"
                            style="border-bottom: 1px solid #000000">
                            <ext:TextField ID="txtDes21" Cls="text_45" runat="server" MaxLength="67" TabIndex="99"
                                Width="670">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td class="font_10_gray">21
                        </td>
                    </tr>
                </table>
            </div>
            <div style="border-top: 1px solid #000000; width: 975px; margin-top: 2px">
                <table cellpadding="0" cellspacing="0" border="0" width="975px">
                    <tr>
                        <td width="300" align="center" class="font_11px_bold2 ae_table" style="padding-top: 5px; padding-bottom: 5px; border-right: 1px solid #000000; border-bottom: 1px solid #000000">FREIGHT DESCRIPTION
                        </td>
                        <td width="140" align="center" class="font_11px_bold2 ae_table" style="border-right: 1px solid #000000; border-bottom: 1px solid #000000">PREPAID
                        </td>
                        <td width="140" align="center" class="font_11px_bold2 ae_table" style="border-bottom: 1px solid #000000">COLLECT
                        </td>
                        <td colspan="2" rowspan="2" valign="top" style="padding-left: 5px; padding-top: 2px; border-bottom: 1px solid #000000; border-left: 1px solid #000000;">The surrender of the...
                        </td>
                    </tr>
                    <tr>
                        <td align="left" class="ae_table">
                            <ext:TextField ID="txtFRDes1" Cls="text_45" runat="server" MaxLength="30" TabIndex="100"
                                Width="300">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td align="left" class="ae_table">
                            <ext:TextField ID="txtPre1" Cls="text_45" TabIndex="101" runat="server" Width="140"
                                StyleSpec="text-align:center" EnableKeyEvents="true">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="KeyNumberLeave(this.id,2);TotalPPCC('PP');out_text(this.id);" />
                                    <KeyUp Handler="KeyNumber(event,this.id);" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td align="left" class="ae_table">
                            <ext:TextField StyleSpec="text-align:center" ID="txtCol1" Cls="text_45" TabIndex="102"
                                runat="server" Width="140" EnableKeyEvents="true">
                                <Listeners>
                                    <Focus Handler="over_text(this.id);" />
                                    <Blur Handler="KeyNumberLeave(this.id,2);TotalPPCC('CC');out_text(this.id);" />
                                    <KeyUp Handler="KeyNumber(event,this.id);" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" class="ae_table">
                            <ext:TextField ID="txtFRDes2" Cls="text_45" runat="server" MaxLength="30" TabIndex="103"
                                Width="300">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td align="left" class="ae_table">
                            <ext:TextField StyleSpec="text-align:center" ID="txtPre2" Cls="text_45" TabIndex="104"
                                runat="server" Width="140" EnableKeyEvents="true">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="KeyNumberLeave(this.id,2);TotalPPCC('PP');out_text(this.id);" />
                                    <KeyUp Handler="KeyNumber(event,this.id);" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td align="left" class="ae_table">
                            <ext:TextField StyleSpec="text-align:center" ID="txtCol2" Cls="text_45" TabIndex="105"
                                runat="server" Width="140" EnableKeyEvents="true">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="KeyNumberLeave(this.id,2);TotalPPCC('CC');out_text(this.id);" />
                                    <KeyUp Handler="KeyNumber(event,this.id);" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td colspan="2" rowspan="2" align="left" valign="top" class="ae_table" style="border-left: 1px solid #000000; border-bottom: 1px solid #000000; padding-left: 5px; padding-top: 2px">IN WITNESS WHEREOF...
                        </td>
                    </tr>
                    <tr>
                        <td align="left" class="ae_table">
                            <ext:TextField ID="txtFRDes3" Cls="text_45" runat="server" MaxLength="30" TabIndex="106"
                                Width="300">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td align="left" class="ae_table">
                            <ext:TextField StyleSpec="text-align:center" ID="txtPre3" Cls="text_45" TabIndex="107"
                                runat="server" Width="140" EnableKeyEvents="true">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="KeyNumberLeave(this.id,2);TotalPPCC('PP');out_text(this.id);" />
                                    <KeyUp Handler="KeyNumber(event,this.id);" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td align="left" class="ae_table">
                            <ext:TextField StyleSpec="text-align:center" ID="txtCol3" Cls="text_45" TabIndex="108"
                                runat="server" Width="140" EnableKeyEvents="true">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="KeyNumberLeave(this.id,2);TotalPPCC('CC');out_text(this.id);" />
                                    <KeyUp Handler="KeyNumber(event,this.id);" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" class="ae_table">
                            <ext:TextField ID="txtFRDes4" Cls="text_45" runat="server" MaxLength="30" TabIndex="109"
                                Width="300">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td align="left" class="ae_table">
                            <ext:TextField StyleSpec="text-align:center" ID="txtPre4" Cls="text_45" TabIndex="110"
                                runat="server" Width="140" EnableKeyEvents="true">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="KeyNumberLeave(this.id,2);TotalPPCC('PP');out_text(this.id);" />
                                    <KeyUp Handler="KeyNumber(event,this.id);" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td align="left" class="ae_table">
                            <ext:TextField StyleSpec="text-align:center" ID="txtCol4" Cls="text_45" TabIndex="111"
                                runat="server" Width="140" EnableKeyEvents="true">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="KeyNumberLeave(this.id,2);TotalPPCC('CC');out_text(this.id);" />
                                    <KeyUp Handler="KeyNumber(event,this.id);" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td colspan="2" align="left" valign="top" class="font_11px_bold2" style="border-left: 1px solid #000000; padding-top: 5px; padding-left: 5px">CONSOLIDATOR INTERNATIONAL CONTAINER SERVICE
                        </td>
                    </tr>
                    <tr>
                        <td align="left" class="ae_table">
                            <ext:TextField ID="txtFRDes5" Cls="text_45" runat="server" MaxLength="30" TabIndex="112"
                                Width="300">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td align="left" class="ae_table">
                            <ext:TextField StyleSpec="text-align:center" ID="txtPre5" Cls="text_45" TabIndex="113"
                                runat="server" Width="140" EnableKeyEvents="true">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="KeyNumberLeave(this.id,2);TotalPPCC('PP');out_text(this.id);" />
                                    <KeyUp Handler="KeyNumber(event,this.id);" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td align="left" class="ae_table">
                            <ext:TextField StyleSpec="text-align:center" ID="txtCol5" Cls="text_45" TabIndex="114"
                                runat="server" Width="140" EnableKeyEvents="true">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="KeyNumberLeave(this.id,2);TotalPPCC('CC');out_text(this.id);" />
                                    <KeyUp Handler="KeyNumber(event,this.id);" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td colspan="2" align="left" class="ae_table" style="border-left: 1px solid #000000">
                            <ext:TextField ID="txtService3" Cls="text_43" TabIndex="131" runat="server" MaxLength="39"
                                Width="390">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" class="ae_table">
                            <ext:TextField ID="txtFRDes6" Cls="text_45" runat="server" MaxLength="30" TabIndex="115"
                                Width="300">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td align="left" class="ae_table">
                            <ext:TextField StyleSpec="text-align:center" ID="txtPre6" Cls="text_45" TabIndex="116"
                                runat="server" Width="140" EnableKeyEvents="true">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="KeyNumberLeave(this.id,2);TotalPPCC('PP');out_text(this.id);" />
                                    <KeyUp Handler="KeyNumber(event,this.id);" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td align="left" class="ae_table">
                            <ext:TextField StyleSpec="text-align:center" ID="txtCol6" Cls="text_45" TabIndex="117"
                                runat="server" Width="140" EnableKeyEvents="true">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="KeyNumberLeave(this.id,2);TotalPPCC('CC');out_text(this.id);" />
                                    <KeyUp Handler="KeyNumber(event,this.id);" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td colspan="2" align="left" class="ae_table" style="border-left: 1px solid #000000">
                            <ext:TextField ID="txtService4" Cls="text_43" TabIndex="131" runat="server" MaxLength="39"
                                Width="390">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id);" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" class="ae_table">
                            <ext:TextField ID="txtFRDes7" Cls="text_45" runat="server" MaxLength="30" TabIndex="118"
                                Width="300">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td align="left" class="ae_table">
                            <ext:TextField StyleSpec="text-align:center" ID="txtPre7" Cls="text_45" TabIndex="119"
                                runat="server" Width="140" EnableKeyEvents="true">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="KeyNumberLeave(this.id,2);TotalPPCC('PP');out_text(this.id);" />
                                    <KeyUp Handler="KeyNumber(event,this.id);" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td align="left" class="ae_table">
                            <ext:TextField StyleSpec="text-align:center" ID="txtCol7" Cls="text_45" TabIndex="120"
                                runat="server" Width="140" EnableKeyEvents="true">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="KeyNumberLeave(this.id,2);TotalPPCC('CC');out_text(this.id);" />
                                    <KeyUp Handler="KeyNumber(event,this.id);" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td colspan="2" align="left" class="ae_table" style="border-left: 1px solid #000000">
                            <ext:TextField ID="txtService1" Cls="text_43" TabIndex="131" runat="server" MaxLength="39"
                                Width="390" EnableKeyEvents="true">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                    <%-- <KeyUp Handler="KeyNumberListener(event,this.id);" />--%>
                                </Listeners>
                            </ext:TextField>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" class="ae_table">
                            <ext:TextField ID="txtFRDes8" Cls="text_45" runat="server" MaxLength="30" TabIndex="121"
                                Width="300">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td align="left" class="ae_table">
                            <ext:TextField StyleSpec="text-align:center" ID="txtPre8" Cls="text_45" TabIndex="122"
                                runat="server" Width="140" EnableKeyEvents="true">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="KeyNumberLeave(this.id,2);TotalPPCC('PP');out_text(this.id);" />
                                    <KeyUp Handler="KeyNumber(event,this.id);" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td align="left" class="ae_table">
                            <ext:TextField StyleSpec="text-align:center" ID="txtCol8" Cls="text_45" TabIndex="123"
                                runat="server" Width="140" EnableKeyEvents="true">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="KeyNumberLeave(this.id,2);TotalPPCC('CC');out_text(this.id);" />
                                    <KeyUp Handler="KeyNumber(event,this.id);" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td colspan="2" align="left" class="ae_table" style="border-left: 1px solid #000000">
                            <ext:TextField ID="txtService2" Cls="text_43" TabIndex="132" runat="server" MaxLength="39"
                                Width="390">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" class="ae_table">
                            <ext:TextField ID="txtFRDes9" Cls="text_45" runat="server" MaxLength="30" TabIndex="124"
                                Width="300">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td align="left" class="ae_table">
                            <ext:TextField StyleSpec="text-align:center" ID="txtPre9" Cls="text_45" TabIndex="124"
                                runat="server" Width="140" EnableKeyEvents="true">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="KeyNumberLeave(this.id,2);TotalPPCC('PP');out_text(this.id);" />
                                    <KeyUp Handler="KeyNumber(event,this.id);" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td align="left" class="ae_table">
                            <ext:TextField StyleSpec="text-align:center" ID="txtCol9" Cls="text_45" TabIndex="125"
                                runat="server" Width="140" EnableKeyEvents="true">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="KeyNumberLeave(this.id,2);TotalPPCC('CC');out_text(this.id);" />
                                    <KeyUp Handler="KeyNumber(event,this.id);" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td colspan="2" align="left" class="ae_table" style="border-left: 1px solid #000000">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="6%" style="padding-left: 4px; padding-right: 5px">BY
                                    </td>
                                    <td width="56%">
                                        <ext:TextField ID="txtBy" Cls="text_45" TabIndex="134" runat="server" MaxLength="20"
                                            Width="200">
                                            <Listeners>
                                                <Focus Handler="over_text(this.id)" />
                                                <Blur Handler="out_text(this.id)" />
                                            </Listeners>
                                        </ext:TextField>
                                    </td>
                                    <td width="10%" style="padding-left: 5px; padding-right: 5px">DATE
                                    </td>
                                    <td width="28%">
                                        <ext:DateField ID="txtDate" Cls="text_45" TabIndex="135" runat="server" Width="120"
                                            HideTrigger="true" StyleSpec="text-align:center">
                                            <Listeners>
                                                <Focus Handler="over_text(this.id)" />
                                                <Blur Handler="out_text(this.id)" />
                                            </Listeners>
                                        </ext:DateField>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" class="ae_table" style="border-bottom: 1px solid #000000">
                            <ext:TextField ID="txtFRDes10" Cls="text_45" runat="server" MaxLength="30" TabIndex="127"
                                Width="300">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="out_text(this.id)" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td align="left" class="ae_table" style="border-bottom: 1px solid #000000">
                            <ext:TextField StyleSpec="text-align:center" ID="txtPre10" Cls="text_45" TabIndex="127"
                                runat="server" Width="140" EnableKeyEvents="true">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="KeyNumberLeave(this.id,2);TotalPPCC('PP');out_text(this.id);" />
                                    <KeyUp Handler="KeyNumber(event,this.id);" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td align="left" class="ae_table" style="border-bottom: 1px solid #000000">
                            <ext:TextField StyleSpec="text-align:center" ID="txtCol10" Cls="text_45" TabIndex="128"
                                runat="server" Width="140" EnableKeyEvents="true">
                                <Listeners>
                                    <Focus Handler="over_text(this.id)" />
                                    <Blur Handler="KeyNumberLeave(this.id,2);TotalPPCC('CC');out_text(this.id);" />
                                    <KeyUp Handler="KeyNumber(event,this.id);KeyNumberListener(event,this.id);" />
                                </Listeners>
                            </ext:TextField>
                        </td>
                        <td width="251" align="left" class="font_11_gray_bold" style="border-left: 1px solid #000000; border-bottom: 1px solid #000000; border-top: 1px solid #000000; padding-left: 4px">CONSOLIDATOR INTERNATIONAL CO., LTD.
                        </td>
                        <td width="144" align="left" class="font_11_gray_bold" style="border-bottom: 1px solid #000000; border-top: 1px solid #000000; padding-left: 5px">AS AGENT
                        </td>
                    </tr>
                    <tr>
                        <td rowspan="3" align="center" class="font_11px_bold2" style="border-bottom: 1px solid #000000; border-right: 1px solid #000000">TOTAL CHARGES
                        </td>
                        <td align="left" class="ae_table">&nbsp;
                        </td>
                        <td align="left" class="ae_table" style="border-left: 1px solid #000000;">&nbsp;
                        </td>
                        <td rowspan="3" align="left" valign="top" class="ae_table" style="border-left: 1px solid #000000; border-bottom: 1px solid #000000; padding-left: 5px; padding-top: 5px">ATTENTION OF SHIPPER...
                        </td>
                        <td align="left" class="ae_table" style="border-left: 1px solid #000000; padding-left: 5px; padding-top: 5px">B/L NO.
                        </td>
                    </tr>
                    <tr>
                        <td align="left" class="ae_table">
                            <table cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <ext:ComboBox ID="txtCharge1Currency" runat="server" Cls="select_160px" StoreID="StoreCurrInvoice"
                                            Width="50" DisplayField="code" ValueField="code" Mode="Local" ForceSelection="true"
                                            HideTrigger="true" TriggerAction="All" TabIndex="23" StyleSpec="text-align:right;">
                                        </ext:ComboBox>
                                    </td>
                                    <td>
                                        <ext:TextField StyleSpec="text-align:center" ID="txtCharge1" Cls="text_45" TabIndex="129"
                                            runat="server" Width="140" Disabled="true">
                                            <%-- <Listeners>
                                        <Focus Handler="over_text(this.id)" />
                                        <Blur Handler="out_text(this.id)" />
                                    </Listeners>--%>
                                        </ext:TextField>
                                    </td>
                                </tr>
                            </table>

                        </td>
                        <td align="left" class="ae_table" style="border-left: 1px solid #000000;">
                            <table cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <ext:ComboBox ID="txtCharge2Currency" runat="server" Cls="select_160px" StoreID="StoreCurrInvoice"
                                            Width="50" DisplayField="code" ValueField="code" Mode="Local" ForceSelection="true"
                                            HideTrigger="true" TriggerAction="All" TabIndex="23" StyleSpec="text-align:right;">
                                        </ext:ComboBox>
                                    </td>
                                    <td>
                                        <ext:TextField StyleSpec="text-align:center" ID="txtCharge2" Disabled="true" Cls="text_45"
                                            TabIndex="130" runat="server" Width="100">
                                            <%-- <Listeners>
                                        <Focus Handler="over_text(this.id)" />
                                        <Blur Handler="out_text(this.id)" />
                                    </Listeners>--%>
                                        </ext:TextField>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td align="center" class="ae_table" style="border-left: 1px solid #000000">
                            <ext:Label ID="labBLNO1" runat="server">
                            </ext:Label>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" class="ae_table" style="border-bottom: 1px solid #000000;">&nbsp;
                        </td>
                        <td align="left" class="ae_table" style="border-bottom: 1px solid #000000; border-left: 1px solid #000000;">&nbsp;
                        </td>
                        <td align="left" class="ae_table" style="border-left: 1px solid #000000; border-bottom: 1px solid #000000;">&nbsp;
                        </td>
                    </tr>
                </table>
            </div>
            <br />
        </div>
    </form>
</body>
</html>
