<%@ Page Language="C#" AutoEventWireup="true" CodeFile="List.aspx.cs" Inherits="AirExport_AEHAWB_List" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<%@ Register Src="../../common/UIControls/AutoComplete.ascx" TagName="AutoComplete"
    TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>AE HAWB</title>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />
    <link href="../../css/AE_HAWB.css" rel="stylesheet" type="text/css" />

    <%--<script src="../../JS/AE.js" type="text/javascript"></script>--%>

    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>

    <script type="text/javascript" src="base.js"></script>

    <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>
    <script src="../../common/ylQuery/Grid.js" type="text/javascript"></script>

    <script src="../../common/UIControls/CompanyDrpList.js" type="text/javascript"></script>

    <style type="text/css">
        .x-form-text, textarea.x-form-field
        {
            background-image: none;
            border-color: White;
        }
        .select
        {
            border-color: #B5B8C8;
            background-image: url("/extjs/resources/images/default/form/text-bg-gif/ext.axd");
        }
    </style>


    <script type="text/javascript">
        function ShipperColor(obj) {

            var color = "#333";
            if (obj.toUpperCase() == "Y")
                color = "#f00";

            for (var i = 1; i <= 5; ++i) {

                $("#txtShipper" + i).css("color", color);
            }
        }

        function ConsigneeColor(obj) {

            var color = "#333";
            if (obj.toUpperCase() == "Y")
                color = "#f00";

            for (var i = 1; i <= 5; ++i) {

                $("#txtConsignee" + i).css("color", color);
            }
        }

        function DimensionsColor(obj) {

            var color = "#333";
            if (obj.toUpperCase() == "Y")
                color = "#f00";

            for (var i = 1; i <= 6; ++i) {

                $("#txtLine" + i).css("color", color);
            }
        }

        function DescriptionColor(obj) {

            var color = "#333";
            if (obj.toUpperCase() == "Y")
                color = "#f00";

            for (var i = 6; i <= 14; ++i) {

                $("#txtLineAll" + i).css("color", color);
            }
        }

        function vwt(obj) {

            if (Number(obj.getValue()) > Number(txtVWT.getValue()))
            { txtCWT1.setValue(formatNumber(obj.getValue(), "###.000#")); }
            else {
                txtCWT1.setValue(formatNumber(txtVWT.getValue(), "###.000#"))
            }
        }

        function showMark() {
            var isIE8 = "false";
            if (navigator.userAgent.indexOf("MSIE") > 0) {
                if (navigator.userAgent.indexOf("MSIE 8.0") > 0) {
                    isIE8 = "true";
                }
            }

            CompanyX.ShowMark(isIE8);
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager runat="server" ID="ResourceManager" DirectMethodNamespace="CompanyX">
    </ext:ResourceManager>
    <ext:Hidden ID="hidShowShipperFlag" runat="server"  Text="1"></ext:Hidden>
    <ext:Hidden ID="hidisb" runat="server"  Text="true"></ext:Hidden>
    <ext:Hidden ID="startLine" runat="server" Text="0">
    </ext:Hidden>
    <ext:Hidden ID="startcount" runat="server" Text="0">
    </ext:Hidden>
    <ext:Hidden ID="hidSeed" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="hidType" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="hidSetInformation" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="txtDescriptionhide" runat="server">
    </ext:Hidden>
    <ext:Hidden ID="txti" runat="server" Text="0"></ext:Hidden>
    <ext:Hidden runat="server" ID="hidAgentCount" Text="">
    </ext:Hidden>
    <ext:Hidden runat="server" ID="hidCarrierCount" Text="">
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
                </Fields>
            </ext:JsonReader>
        </Reader>
    </ext:Store>
    <%--    <ext:Store runat="server" ID="StoreCompany">
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
    </ext:Store>--%>
    <div style="padding-left: 10px;">
        <div id="div_title" style="width: 937px; padding-top: 10px">
            <table width="935px" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF"
                style="height: 34px; width: 100%; border: 1px solid #000000">
                <tr>
                <td style="padding-left:5px"><table><tr>
                <td><img src="/images/arrows_btn.png" id="img_showlist" style="cursor: pointer; vertical-align: middle"
                                    alt="View" onclick="createFrom('AEHAWB');" /></td>
                <td style="padding-left:5px" class="font_12px"><%=Request["type"]=="m"?"AE MAWB":"AE HAWB" %></td></tr></table></td>
                    <td valign="middle" align="right" style="padding-right:5px">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td >
                                    <span>
                                        <ext:Button ID="btnPrint" runat="server" Text="Print" Cls="Submit_65px" Width="60px"
                                            StyleSpec="margin:0px 2px;">
                                            <DirectEvents>
                                                <Click OnEvent="btnPrint_Click">
                                                    <EventMask Msg=" Saving... " ShowMask="true" />
                                                </Click>
                                            </DirectEvents>
                                        </ext:Button>
                                    </span>
                                </td>
                                <td>
                                    <ext:Hidden runat="server" ID="chkItem1" Text="1">
                                    </ext:Hidden>
                                    <ext:Hidden runat="server" ID="chkOther1" Text="1">
                                    </ext:Hidden>
                                    <ext:Hidden runat="server" ID="chkShowInManifest1" Text="1">
                                    </ext:Hidden>
                                    <span>
                                        <ext:Button ID="btnOption" runat="server" Text="Option" Cls="Submit_65px" Width="65"
                                            StyleSpec="margin:0px 2px;">
                                            <Menu>
                                                <ext:Menu ID="Menu1" runat="server">
                                                    <Items>
                                                        <ext:Checkbox ID="chkShowInManifest" BoxLabel="Show in Manifest" Checked="true" runat="server">
                                                            <Listeners>
                                                                <Check Handler="if(this.checked){chkShowInManifest1.setValue('1')}else{chkShowInManifest1.setValue('0')};" />
                                                            </Listeners>
                                                            <DirectEvents>
                                                                <Check OnEvent="chkShowInManifest_Check">
                                                                    <EventMask ShowMask="true" Target="Page" />
                                                                </Check>
                                                            </DirectEvents>
                                                        </ext:Checkbox>
                                                        <ext:Checkbox ID="chkItem" BoxLabel="Item value as arrange" Checked="true" runat="server">
                                                            <Listeners>
                                                                <Check Handler="if(this.checked){chkItem1.setValue('1')}else{chkItem1.setValue('0')}; CheckList();" />
                                                            </Listeners>
                                                        </ext:Checkbox>
                                                        <ext:Checkbox ID="chkOther" BoxLabel="Other charge as arrange" Checked="true" runat="server">
                                                            <Listeners>
                                                                <Check Handler="if(this.checked){chkOther1.setValue('1')}else{chkOther1.setValue('0')};CheckList();" />
                                                            </Listeners>
                                                        </ext:Checkbox>
                                                    </Items>
                                                </ext:Menu>
                                            </Menu>
                                        </ext:Button>
                                    </span>
                                </td>
                                <td>
                                    <span>
                                        <ext:Button ID="btnMan" runat="server" Text="Manifest" Cls="Submit_150px" StyleSpec="margin:0px 2px;"
                                            Width="65">
                                            <DirectEvents>
                                                <Click OnEvent="btnMan_Click">
                                                </Click>
                                            </DirectEvents>
                                        </ext:Button>
                                    </span>
                                </td>
                                <td>
                                    <ext:Button ID="btnDescription" runat="server" Text="Manifest" Hidden="true" StyleSpec="margin:0px 2px;">
                                        <Listeners>
                                            <Click Handler="CompanyX.ShowDescription();" />
                                        </Listeners>
                                    </ext:Button>
                                </td>
                                <td>
                                    <span>
                                        <ext:Button ID="btnModify" runat="server" Text="Modify" Cls="Submit_65px" Width="65"
                                            StyleSpec="margin:0px 2px;">
                                           <%-- <DirectEvents>
                                                <Click OnEvent="btnModify_Click">
                                                </Click>
                                            </DirectEvents>--%>
                                            <Listeners>
                                                <Click Handler="#{windowconfirm}.show();#{windowconfirm}.focus();$('#txtpass').focus();" />
                                            </Listeners>
                                        </ext:Button>
                                    </span>
                                </td>
                                <td>
                                    <span>
                                        <ext:Button ID="btnSave" runat="server" Text="Save" Cls="Submit_65px" StyleSpec="margin:0px 2px;">
                                            <Listeners>
                                                <Click Handler="return ReturnNull();" />
                                            </Listeners>
                                            <DirectEvents>
                                                <Click OnEvent="btnSave_Click">
                                                    <EventMask Msg=" Saving... " ShowMask="true" />
                                                </Click>
                                            </DirectEvents>
                                        </ext:Button>
                                    </span>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <table cellpadding="0" cellspacing="0" border="0" style="height: 30px; margin-top: 10px"
                width="100%">
                <tr>
                    <td style="border-bottom: 1px solid #000000; padding-right: 20px">
                    </td>
                    <td style="border-bottom: 1px solid #000000; border-right: 1px solid #000000;">
                    </td>
                    <td style="border-bottom: 1px solid #000000; border-right: 1px solid #000000; width: 55px">
                    </td>
                    <td align="left" width="50%" valign="top" style="padding-top: 10px; padding-left: 8px;
                        border-bottom: 1px solid #000000;">
                        <ext:Label ID="labMawbNo" runat="server" Cls="Courier" StyleSpec="color:#ff0000;font-weight: bold; padding-right:5px">
                        </ext:Label>
                    </td>
                    <td align="right" valign="top" style="padding-top: 8px; border-bottom: 1px solid #000000;">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td style="font-weight: bold;">
                                    <ext:Label ID="labHAwbFlag" runat="server" Text="HAWB No.:" Cls="Courier">
                                    </ext:Label>
                                </td>
                                <td style="padding-right: 10px; padding-left: 5px; padding-bottom:3px; text-align: left; width: 130px">
                                    <ext:Label ID="labHawbNo" runat="server" StyleSpec="padding-right:10px" Cls="Courier_red">
                                    </ext:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
        <table width="952px" border="0" cellspacing="0" cellpadding="0" style="margin-top: 83px">
            <tr>
                <td width="937px" valign="top">
                    <table border="0" cellspacing="0" cellpadding="0" width="937px">
                        <tr>
                            <td class="boder_line" ><%--colspan="2"--%>
                                <table cellpadding="0" cellspacing="0" border="0" width="448px">
                                    <tr>
                                        <td align="left" style="padding-left: 3px;width:200px;">
                                            Shipper' s Name and Address
                                        </td>
                                        <td align="left" style="padding-top: 3px; padding-left: 42px">
                                            <uc1:AutoComplete runat="server" ID="CmbShipperCode" clsClass="text_82px" isAlign="false"
                                                isDiplay="false" isButton="false" isText="false" Width="200" winTitle="Company"
                                                winUrl="/BasicData/Customer/detail.aspx" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="483" rowspan="5" align="left" valign="top" class="boder_line boder_line_05"
                                id="padding03">
                                <table width="480px" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td width="120" style="padding-top: 5px; padding-left: 5px">
                                            NOT
                                            <notbr>NEGOTIBALE</notbr>
                                            <br />
                                            <span class="font_13px">Air Waybill</span><br />
                                            Issued by<br />
                                            <br />
                                        </td>
                                        <td width="370" class="font_14px_1542af " style="padding-left: 110px; font-size: 18px;">
                                            <ext:Label ID="labhawbormawb" runat="server">
                                            </ext:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 0" colspan="2">
                                            <ext:TextField ID="txtCarrier1" Cls="text_45" TabIndex="1" runat="server" Width="480"
                                                MaxLength="43" StyleSpec="text-align:center">
                                                <Listeners>
                                                    <Focus Handler="over_text('txtCarrier1')" />
                                                    <Blur Handler="out_text('txtCarrier1')" />
                                                </Listeners>
                                            </ext:TextField>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <ext:TextField ID="txtCarrier2" Cls="text_45" TabIndex="1" runat="server" Width="480"
                                                MaxLength="43" StyleSpec="text-align:center">
                                                <Listeners>
                                                    <Focus Handler="over_text('txtCarrier2')" />
                                                    <Blur Handler="out_text('txtCarrier2')" />
                                                </Listeners>
                                            </ext:TextField>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="left" valign="top" class="boder_line_04 ae_table" id="padding05">
                                <ext:TextField ID="txtShipper1" Cls="text_45" TabIndex="1" runat="server" Width="439"
                                    MaxLength="43">
                                    <Listeners>
                                        <Focus Handler="over_text('txtShipper1')" />
                                        <Blur Handler="out_text('txtShipper1')" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="left" valign="top" class="boder_line_08 ae_table" id="padding08">
                                <ext:TextField ID="txtShipper2" Cls="text_45" TabIndex="2" runat="server" Width="439"
                                    MaxLength="43">
                                    <Listeners>
                                        <Focus Handler="over_text('txtShipper2')" />
                                        <Blur Handler="out_text('txtShipper2')" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                        </tr>
                        <tr>
                            <td  align="left" valign="top" class="boder_line_08 ae_table" id="padding08"><%--colspan="2"--%>
                                <ext:TextField ID="txtShipper3" Cls="text_45" TabIndex="3" runat="server" Width="439"
                                    MaxLength="43">
                                    <Listeners>
                                        <Focus Handler="over_text('txtShipper3')" />
                                        <Blur Handler="out_text('txtShipper3')" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                        </tr>
                        <tr>
                            <td  align="left" valign="top" class="boder_line_08 ae_table" id="padding08"><%--colspan="2"--%>
                                <ext:TextField ID="txtShipper4" Cls="text_45" TabIndex="4" runat="server" Width="439"
                                    MaxLength="43">
                                    <Listeners>
                                        <Focus Handler="over_text('txtShipper4')" />
                                        <Blur Handler="out_text('txtShipper4')" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                        </tr>
                        <tr>
                            <td  align="left" valign="top" class="boder_line_08 ae_table" id="padding08"><%--colspan="2"--%>
                                <ext:TextField ID="txtShipper5" Cls="text_45" TabIndex="5" runat="server" Width="439"
                                    MaxLength="43">
                                    <Listeners>
                                        <Focus Handler="over_text('txtShipper5')" />
                                        <Blur Handler="out_text('txtShipper5')" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                            <td align="left" class="boder_line boder_line_05  font_11_gray" style="padding-left: 10px">
                                Copies 1, 2 and 3 of this Air Waybill are originals and have the same validity
                            </td>
                        </tr>
                        <tr>
                            <td class="boder_line boder_line_02" ><%--colspan="2"--%>
                                <table cellpadding="0" cellspacing="0" border="0" width="448px">
                                    <tr>
                                        <td align="left" style="padding-left: 3px;width:200px;">
                                            Consignee' s Name and Address
                                        </td>
                                        <td align="right" style="padding-left: 42px; padding-top: 3px">
                                            <uc1:AutoComplete runat="server" ID="CmbConsigneeCode" clsClass="text_82px" isAlign="false"
                                                isDiplay="false" isButton="false" isText="false" Width="200" winTitle="Company"
                                                winUrl="/BasicData/Customer/detail.aspx" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td align="left" class="boder_line boder_line_05  font_11_gray" id="padding03" style="padding-left: 10px;
                                padding-top: 5px" rowspan="6" valign="top">
                                <table width="100%" height="120px" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td colspan="2" style="vertical-align: top;">
                                            It is agreed....
                                        </td>
                                    </tr>
                                    <tr style="padding-bottom: 7px" valign="bottom">
                                        <td align="left">
                                            <ext:Label ID="labppcc" Cls="text_45" runat="server" StyleSpec="color:#ff0000;font-weight: bold">
                                            </ext:Label>
                                        </td>
                                        <td align="right">
                                            <ext:Label ID="lablotno" Cls="text_45" runat="server" StyleSpec="color:#ff0000;font-weight: bold;padding-right:10px;">
                                            </ext:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="left" class="boder_line_04 ae_table" id="padding04">
                                <ext:TextField ID="txtConsignee1" Cls="text_45" TabIndex="6" runat="server" Width="439"
                                    MaxLength="43">
                                    <Listeners>
                                        <Focus Handler="over_text('txtConsignee1')" />
                                        <Blur Handler="out_text('txtConsignee1')" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="left" class="boder_line_08 ae_table" id="padding04">
                                <ext:TextField ID="txtConsignee2" Cls="text_45" TabIndex="7" runat="server" Width="439"
                                    MaxLength="43">
                                    <Listeners>
                                        <Focus Handler="over_text('txtConsignee2')" />
                                        <Blur Handler="out_text('txtConsignee2')" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="left" class="boder_line_08 ae_table" id="padding04">
                                <ext:TextField ID="txtConsignee3" Cls="text_45" TabIndex="8" runat="server" Width="439"
                                    MaxLength="43">
                                    <Listeners>
                                        <Focus Handler="over_text('txtConsignee3')" />
                                        <Blur Handler="out_text('txtConsignee3')" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="left" class="boder_line_08 ae_table" id="padding04">
                                <ext:TextField ID="txtConsignee4" Cls="text_45" TabIndex="9" runat="server" Width="439"
                                    MaxLength="43">
                                    <Listeners>
                                        <Focus Handler="over_text('txtConsignee4')" />
                                        <Blur Handler="out_text('txtConsignee4')" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="left" class="boder_line_08 ae_table" id="padding04">
                                <ext:TextField ID="txtConsignee5" Cls="text_45" TabIndex="10" runat="server" Width="439"
                                    MaxLength="43">
                                    <Listeners>
                                        <Focus Handler="over_text('txtConsignee5')" />
                                        <Blur Handler="out_text('txtConsignee5')" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                        </tr>
                        <tr>
                            <td class="boder_line boder_line_02" ><%--colspan="2"--%>
                                <table cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td align="left" style="padding-left: 3px;width:200px;">
                                           Notify Party
                                        </td>
                                        <td align="right" style="padding-left: 42px;padding-right:2px; padding-top: 3px">
                                            <uc1:AutoComplete runat="server" ID="CmbParty1" clsClass="text_82px" isAlign="false"
                                                isDiplay="false" isButton="false" isText="false" Width="200" winTitle="Company"
                                                winUrl="/BasicData/Customer/detail.aspx" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td align="left" class="boder_line boder_line_05" style="padding-left: 3px">
                                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td>
                                            Accounting Information
                                        </td>
                                        <td align="right" style="padding-top: 3px; padding-right: 3px; padding-left: 162px">
                                            <uc1:AutoComplete runat="server" ID="CmbParty2" clsClass="text_82px" isAlign="false"
                                                isDiplay="false" isButton="false" isText="false" Width="200" winTitle="Company"
                                                winUrl="/BasicData/Customer/detail.aspx" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td  align="left" valign="top" class="boder_line_04 ae_table" id="padding04"><%--colspan="2"--%>
                                <ext:TextField ID="txtPartyA1" Cls="text_45" TabIndex="11" runat="server" Width="439"
                                    MaxLength="43">
                                    <Listeners>
                                        <Focus Handler="over_text('txtPartyA1')" />
                                        <Blur Handler="out_text('txtPartyA1')" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                            <td align="left" class="boder_line_06 ae_table" id="padding05">
                                <ext:TextField ID="txtPartyB1" Cls="text_45" TabIndex="17" runat="server" Width="470"
                                    MaxLength="46">
                                    <Listeners>
                                        <Focus Handler="over_text('txtPartyB1')" />
                                        <Blur Handler="out_text('txtPartyB1')" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                        </tr>
                        <tr>
                            <td  align="left" valign="top" class="boder_line_08 ae_table" id="padding04"><%--colspan="2"--%>
                                <ext:TextField ID="txtPartyA2" Cls="text_45" TabIndex="12" runat="server" Width="439"
                                    MaxLength="43">
                                    <Listeners>
                                        <Focus Handler="over_text('txtPartyA2')" />
                                        <Blur Handler="out_text('txtPartyA2')" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                            <td align="left" class="boder_line_06 ae_table" id="padding08">
                                <ext:TextField ID="txtPartyB2" Cls="text_45" TabIndex="18" runat="server" Width="470"
                                    MaxLength="46">
                                    <Listeners>
                                        <Focus Handler="over_text('txtPartyB2')" />
                                        <Blur Handler="out_text('txtPartyB2')" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                        </tr>
                        <tr>
                            <td  align="left" valign="top" class="boder_line_08 ae_table" id="padding04"><%--colspan="2"--%>
                                <ext:TextField ID="txtPartyA3" Cls="text_45" TabIndex="13" runat="server" Width="439"
                                    MaxLength="43">
                                    <Listeners>
                                        <Focus Handler="over_text('txtPartyA3')" />
                                        <Blur Handler="out_text('txtPartyA3')" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                            <td align="left" class="boder_line_06 ae_table" id="padding08">
                                <ext:TextField ID="txtPartyB3" Cls="text_45" TabIndex="19" runat="server" Width="470"
                                    MaxLength="46">
                                    <Listeners>
                                        <Focus Handler="over_text('txtPartyB3')" />
                                        <Blur Handler="out_text('txtPartyB3')" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" valign="top" class="boder_line" id="td_mawb1" runat="server" style="padding-left: 3px;
                                display: none">
                                Agent' s IATA Code
                            </td>
                            <td align="left" valign="top" class="boder_line" id="td_mawb2" runat="server" style="padding-left: 5px;
                                display: none;">
                                Account No.
                            </td>
                            <td  align="left" valign="top" class="boder_line_08 ae_table" id="td_hawb1"
                                runat="server"><%--colspan="2"--%>
                                <ext:TextField ID="TextField1" Cls="text_45" TabIndex="13" runat="server" Width="439"
                                    MaxLength="43">
                                    <Listeners>
                                        <Focus Handler="over_text('TextField1')" />
                                        <Blur Handler="out_text('TextField1')" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                            <td align="left" class="boder_line_06 ae_table" id="padding08">
                                <ext:TextField ID="txtPartyB4" Cls="text_45" TabIndex="20" runat="server" Width="470"
                                    MaxLength="46">
                                    <Listeners>
                                        <Focus Handler="over_text('txtPartyB4')" />
                                        <Blur Handler="out_text('txtPartyB4')" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" valign="top" class="boder_line_04 ae_table" id="td_mawb3" runat="server"
                                style="display: none">
                                <ext:TextField ID="txtAgent" Cls="text_45" TabIndex="14" runat="server" Width="216"
                                    MaxLength="21">
                                    <Listeners>
                                        <Focus Handler="over_text('txtAgent')" />
                                        <Blur Handler="out_text('txtAgent')" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                            <td align="left" valign="top" class="boder_line_04 ae_table" id="td_mawb4" runat="server"
                                style="display: none">
                                <ext:TextField ID="txtAccount" Cls="text_45" TabIndex="15" runat="server" Width="225"
                                    MaxLength="22">
                                    <Listeners>
                                        <Focus Handler="over_text('txtAccount')" />
                                        <Blur Handler="out_text('txtAccount')" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                            <td  align="left" valign="top" class="boder_line_08 ae_table" id="td_hawb2"
                                runat="server"><%--colspan="2"--%>
                                <ext:TextField ID="TextField2" Cls="text_45" TabIndex="13" runat="server" Width="439"
                                    MaxLength="43">
                                    <Listeners>
                                        <Focus Handler="over_text('TextField2')" />
                                        <Blur Handler="out_text('TextField2')" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                            <td align="left" class="boder_line_06 ae_table" id="padding08">
                                <ext:TextField ID="txtPartyB5" Cls="text_45" TabIndex="21" runat="server" Width="470"
                                    MaxLength="46">
                                    <Listeners>
                                        <Focus Handler="over_text('txtPartyB5')" />
                                        <Blur Handler="out_text('txtPartyB5')" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                        </tr>
                        <tr>
                            <td  align="left" valign="top" class="boder_line" id="padding02" style="padding-left: 3px"><%--colspan="2"--%>
                                Airport of Departure (Addr. of First Carrier) and Requested Routing
                            </td>
                            <td align="left" class="boder_line_06 ae_table" id="padding08">
                                <ext:TextField ID="txtPartyB6" Cls="text_45" TabIndex="22" runat="server" Width="470"
                                    MaxLength="46">
                                    <Listeners>
                                        <Focus Handler="over_text('txtPartyB6')" />
                                        <Blur Handler="out_text('txtPartyB6')" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                        </tr>
                        <tr>
                            <td  align="left" valign="top" class="boder_line_04 ae_table" id="padding08"><%--colspan="2"--%>
                                <ext:TextField ID="txtDeparture" Cls="text_45" TabIndex="16" runat="server" Width="441"
                                    MaxLength="43">
                                    <Listeners>
                                        <Focus Handler="over_text('txtDeparture')" />
                                        <Blur Handler="out_text('txtDeparture')" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                            <td align="left" valign="top" class="boder_line_06 ae_table" id="padding08">
                                <ext:TextField ID="txtPartyB7" Cls="text_45" TabIndex="23" runat="server" Width="470"
                                    MaxLength="46">
                                    <Listeners>
                                        <Focus Handler="over_text('txtPartyB7')" />
                                        <Blur Handler="out_text('txtPartyB7')" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                        </tr>
                        <tr>
                            <td  align="left" valign="top"><%--colspan="2"--%>
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td width="11%" align="left" valign="top" class="boder_line" id="padding03" style="height: 29px;
                                            padding-left: 3px">
                                            to
                                        </td>
                                        <td width="52%" align="left" valign="top" class="boder_line">
                                            <table width="211" border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="80">
                                                        <table width="80" border="0" cellspacing="0" cellpadding="0">
                                                            <tr>
                                                                <td>
                                                                    &nbsp;By First Carrier
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="141" valign="top">
                                                        <img src="../../images/table/title_01.jpg" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="11%" align="left" valign="top" class="boder_line" id="padding03">
                                            to
                                        </td>
                                        <td width="7%" align="left" valign="top" class="boder_line" id="padding03">
                                            by
                                        </td>
                                        <td colspan="2" align="left" valign="top" class="boder_line" id="padding03">
                                            to
                                        </td>
                                        <td width="7%" align="left" valign="top" class="boder_line" id="padding03">
                                            by
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" valign="top" class="boder_line_04 ae_table" id="padding06" height="19px">
                                            <ext:TextField ID="txtTo" Cls="text_43" TabIndex="23" runat="server" Width="50" MaxLength="5">
                                                <Listeners>
                                                    <Focus Handler="over_text('txtTo')" />
                                                    <Blur Handler="out_text('txtTo')" />
                                                </Listeners>
                                            </ext:TextField>
                                        </td>
                                        <td align="left" valign="top" class="boder_line_04 ae_table" id="padding06">
                                            <ext:TextField ID="txtFde" Cls="text_43" TabIndex="24" runat="server" Width="228"
                                                MaxLength="21">
                                                <Listeners>
                                                    <Focus Handler="over_text('txtFde')" />
                                                    <Blur Handler="out_text('txtFde')" />
                                                </Listeners>
                                            </ext:TextField>
                                        </td>
                                        <td align="left" valign="top" class="boder_line_04 ae_table" id="padding06">
                                            <ext:TextField ID="txtTo2" Cls="text_43" TabIndex="25" runat="server" Width="50"
                                                MaxLength="5">
                                                <Listeners>
                                                    <Focus Handler="over_text('txtTo2')" />
                                                    <Blur Handler="out_text('txtTo2')" />
                                                </Listeners>
                                            </ext:TextField>
                                        </td>
                                        <td align="left" valign="top" class="boder_line_04 ae_table" id="padding06">
                                            <ext:TextField ID="txtBy2" Cls="text_43" TabIndex="26" runat="server" Width="30"
                                                MaxLength="3">
                                                <Listeners>
                                                    <Focus Handler="over_text('txtBy2')" />
                                                    <Blur Handler="out_text('txtBy2')" />
                                                </Listeners>
                                            </ext:TextField>
                                        </td>
                                        <td colspan="2" align="left" valign="top" class="boder_line_04 ae_table" id="padding06">
                                            <ext:TextField ID="txtTo3" Cls="text_43" TabIndex="27" runat="server" Width="50"
                                                MaxLength="5">
                                                <Listeners>
                                                    <Focus Handler="over_text('txtTo3')" />
                                                    <Blur Handler="out_text('txtTo3')" />
                                                </Listeners>
                                            </ext:TextField>
                                        </td>
                                        <td align="left" valign="top" class="boder_line_04 ae_table" id="padding06">
                                            <ext:TextField ID="txtBy3" Cls="text_43" TabIndex="28" runat="server" Width="30"
                                                MaxLength="3">
                                                <Listeners>
                                                    <Focus Handler="over_text('txtBy3')" />
                                                    <Blur Handler="out_text('txtBy3')" />
                                                </Listeners>
                                            </ext:TextField>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td align="left" valign="top">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td width="10%" rowspan="2" align="center" valign="top" class="boder_line" height="27px">
                                            Currency
                                        </td>
                                        <td width="6%" height="27" rowspan="2" align="center" valign="top" class="boder_line font_8px"
                                            id="padding03">
                                            GHSS<br />
                                            Code
                                        </td>
                                        <td colspan="2" align="center" valign="top" class="boder_line font_8px" id="padding03">
                                            WT / VAL
                                        </td>
                                        <td colspan="2" align="center" valign="top" class="boder_line font_8px" id="padding03">
                                            Other
                                        </td>
                                        <td width="31%" rowspan="2" align="center" valign="top" class="boder_line" id="padding02">
                                            Declared Value for Carriage
                                        </td>
                                        <td width="32%" rowspan="2" align="center" valign="top" class="boder_line boder_line_05"
                                            id="padding02">
                                            Declared Value for Customs
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="5%" height="17" align="center" valign="top" class="boder_line font_8px"
                                            id="padding03">
                                            PPD
                                        </td>
                                        <td width="6%" align="center" valign="top" class="boder_line font_8px" id="padding03">
                                            COLL
                                        </td>
                                        <td width="5%" align="center" valign="top" class="boder_line font_8px" id="padding03">
                                            PPD
                                        </td>
                                        <td width="5%" align="center" valign="top" class="boder_line font_8px" id="padding03">
                                            COLL
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" valign="top" class="boder_line_04 ae_table" id="padding06" style="background-color: #fbb">
                                            <ext:TextField ID="txtCurrency" Cls="text_44" TabIndex="29" runat="server" Width="50"
                                                MaxLength="5">
                                                <Listeners>
                                                    <Focus Handler="over_text('txtCurrency')" />
                                                    <Blur Handler="out_text('txtCurrency')" />
                                                </Listeners>
                                            </ext:TextField>
                                        </td>
                                        <td align="left" valign="top" class="boder_line_04 ae_table" id="padding06" style="background-color: #fbb">
                                            <ext:TextField ID="txtGhSS" Cls="text_44" TabIndex="30" runat="server" Width="30"
                                                EnableKeyEvents="true" StyleSpec="text-align:center;ime-mode: disabled;" MaxLength="2">
                                                <Listeners>
                                                    <Focus Handler="over_text('txtGhSS')" />
                                                    <Blur Handler="out_textGhSS('txtGhSS');if(this.getValue()=='PP'||this.getValue()=='PC'||this.getValue()=='P'){labppcc.setText('FREIGHT PREPAID');} else if(this.getValue()=='CC'||this.getValue()=='CP'||this.getValue()=='C'){labppcc.setText('FREIGHT COLLECT');} else{labppcc.setText('');}" />
                                                    <Change Handler="out_textGhSS('txtGhSS');if(this.getValue()=='PP'||this.getValue()=='PC'||this.getValue()=='P'){labppcc.setText('FREIGHT PREPAID');} else if(this.getValue()=='CC'||this.getValue()=='CP'||this.getValue()=='C'){labppcc.setText('FREIGHT COLLECT');} else{labppcc.setText('');}" />
                                                    <KeyPress Handler="Keyshow(event);" />
                                                </Listeners>
                                            </ext:TextField>
                                        </td>
                                        <td align="left" valign="top" class="boder_line_04 ae_table" id="padding06" style="background-color: #fbb">
                                            <ext:TextField ID="txtWTPPD" Cls="text_44" TabIndex="31" runat="server" Width="25"
                                                EnableKeyEvents="true" StyleSpec="text-align:center;ime-mode: disabled;" MaxLength="1">
                                                <Listeners>
                                                    <Focus Handler="over_text('txtWTPPD')" />
                                                    <Blur Handler="out_text('txtWTPPD');" />
                                                    <Change Handler="if(this.getValue()!=''){txtWTColl.setValue(''); changePPCC();CheckList();SetRate();}" />
                                                    <KeyPress Handler="if(event.keyCode!=80&&event.keyCode!=112){event.returnValue=false;};" />
                                                </Listeners>
                                            </ext:TextField>
                                        </td>
                                        <td align="left" valign="top" class="boder_line_04 ae_table" id="padding06" style="background-color: #fbb">
                                            <ext:TextField ID="txtWTColl" Cls="text_44" TabIndex="32" runat="server" Width="25"
                                                MaxLength="1" StyleSpec="text-align:center;ime-mode: disabled;" EnableKeyEvents="true">
                                                <Listeners>
                                                    <Focus Handler="over_text('txtWTColl');" />
                                                    <Blur Handler="out_text('txtWTColl');" />
                                                    <Change Handler="if(this.getValue()!=''){txtWTPPD.setValue(''); changePPCC();CheckList();SetRate();}" />
                                                    <KeyPress Handler="if(event.keyCode!=99&&event.keyCode!=67){event.returnValue=false;};" />
                                                </Listeners>
                                            </ext:TextField>
                                        </td>
                                        <td align="left" valign="top" class="boder_line_04 ae_table" id="padding06" style="background-color: #fbb">
                                            <ext:TextField ID="txtOtherPPD" Cls="text_44" TabIndex="33" runat="server" Width="25"
                                                MaxLength="1" StyleSpec="text-align:center;ime-mode: disabled;" EnableKeyEvents="true">
                                                <Listeners>
                                                    <Focus Handler="over_text('txtOtherPPD')" />
                                                    <Blur Handler="out_text('txtOtherPPD');" />
                                                    <Change Handler="if(this.getValue()!=''){txtOtherColl.setValue('');changePPCC();CheckList();}" />
                                                    <KeyPress Handler="if(event.keyCode!=80&&event.keyCode!=112){event.returnValue=false;};" />
                                                </Listeners>
                                            </ext:TextField>
                                        </td>
                                        <td align="left" valign="top" class="boder_line_04 ae_table" id="padding06" style="background-color: #fbb">
                                            <ext:TextField ID="txtOtherColl" Cls="text_44" TabIndex="34" runat="server" Width="25"
                                                MaxLength="1" StyleSpec="text-align:center;ime-mode: disabled;" EnableKeyEvents="true">
                                                <Listeners>
                                                    <Focus Handler="over_text('txtOtherColl')" />
                                                    <Blur Handler="out_text('txtOtherColl');" />
                                                    <Change Handler="if(this.getValue()!=''){txtOtherPPD.setValue('');changePPCC();CheckList();}" />
                                                    <KeyPress Handler="if(event.keyCode!=99&&event.keyCode!=67){event.returnValue=false;};" />
                                                </Listeners>
                                            </ext:TextField>
                                        </td>
                                        <td align="left" valign="top" class="boder_line_04 ae_table" id="padding04">
                                            <ext:TextField ID="txtCarriage" Cls="text_43" TabIndex="35" runat="server" Width="142"
                                                MaxLength="14">
                                                <Listeners>
                                                    <Focus Handler="over_text('txtCarriage')" />
                                                    <Blur Handler="out_text('txtCarriage')" />
                                                </Listeners>
                                            </ext:TextField>
                                        </td>
                                        <td align="left" valign="top" class="boder_line_06 ae_table" id="padding04">
                                            <ext:TextField ID="txtCustomer" Cls="text_43" TabIndex="36" runat="server" Width="150"
                                                MaxLength="15">
                                                <Listeners>
                                                    <Focus Handler="over_text('txtCustomer')" />
                                                    <Blur Handler="out_text('txtCustomer')" />
                                                </Listeners>
                                            </ext:TextField>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" valign="top"><%--colspan="2"--%>
                                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td align="center" valign="top" class="boder_line" id="padding03">
                                            Airport of Destination
                                        </td>
                                        <td colspan="3" align="left" valign="top" class="boder_line">
                                            <table width="200px" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td width="65" id="padding03">
                                                        Flight/Date
                                                    </td>
                                                    <td width="140" align="center" valign="bottom">
                                                        <img src="../../images/table/title_02.jpg" />
                                                    </td>
                                                    <td width="67" id="padding03">
                                                        Flight/Date
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="201" align="center" valign="top" class="boder_line_04 ae_table" id="padding06">
                                            <ext:TextField ID="txtDest" Cls="text_43" TabIndex="37" runat="server" Width="198"
                                                MaxLength="21">
                                                <Listeners>
                                                    <Focus Handler="over_text('txtDest')" />
                                                    <Blur Handler="out_text('txtDest')" />
                                                </Listeners>
                                            </ext:TextField>
                                        </td>
                                        <td width="113" align="left" valign="top" class="boder_line_04 ae_table" id="padding06">
                                            <ext:TextField ID="txtFlightDate1" Cls="text_43" TabIndex="38" runat="server" Width="113"
                                                MaxLength="11">
                                                <Listeners>
                                                    <Focus Handler="over_text('txtFlightDate1')" />
                                                    <Blur Handler="out_text('txtFlightDate1')" />
                                                </Listeners>
                                            </ext:TextField>
                                        </td>
                                        <td align="left" valign="top" class="boder_line_04 ae_table" id="padding06">
                                            <ext:TextField ID="txtFlightDate2" Cls="text_43" TabIndex="39" runat="server" Width="135" MaxLength="11">
                                                <Listeners>
                                                    <Focus Handler="over_text('txtFlightDate2')" />
                                                    <Blur Handler="out_text('txtFlightDate2')" />
                                                </Listeners>
                                            </ext:TextField>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td align="left" valign="top">
                                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td width="108" align="left" valign="top" class="boder_line boder_line_05" id="padding03"
                                            style="padding-top: 1px; padding-bottom: 2px">
                                            Amount of Insurance
                                        </td>
                                        <td width="398" rowspan="3" align="left" valign="top" class="boder_line_09 font_11_gray"
                                            id="padding02" style="padding-left: 10px; padding-top: 2px">
                                            INSURANCE - if carrier offers insurance....
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" valign="top" class="boder_line_06 ae_table" id="padding06">
                                            <ext:TextField ID="txtInsur" Cls="text_43" TabIndex="40" runat="server" Width="118">
                                                <Listeners>
                                                    <Focus Handler="over_text('txtInsur')" />
                                                    <Blur Handler="out_text('txtInsur')" />
                                                </Listeners>
                                            </ext:TextField>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" align="left" valign="top" class="boder_line boder_line_05" style="padding-left: 3px">
                                Handling Information
                            </td>
                        </tr>
                        <tr>
                            <td height="15" colspan="3" align="left" valign="top" class="boder_line_06 ae_table"
                                id="padding07">
                                <ext:TextField ID="txtHandle1" Cls="text_45" TabIndex="41" runat="server" Width="933"
                                    MaxLength="89">
                                    <Listeners>
                                        <Focus Handler="over_text('txtHandle1')" />
                                        <Blur Handler="out_text('txtHandle1')" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                        </tr>
                        <tr>
                            <td height="15" colspan="3" align="left" valign="top" class="boder_line_06 ae_table"
                                id="padding03">
                                <ext:TextField ID="txtHandle2" Cls="text_45" TabIndex="42" runat="server" Width="933"
                                    MaxLength="89">
                                    <Listeners>
                                        <Focus Handler="over_text('txtHandle2')" />
                                        <Blur Handler="out_text('txtHandle2')" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" align="left" valign="top" class="boder_line_06  ae_table" id="padding03">
                                <ext:TextField ID="txtHandle3" Cls="text_45" TabIndex="43" runat="server" Width="933"
                                    MaxLength="89">
                                    <Listeners>
                                        <Focus Handler="over_text('txtHandle3')" />
                                        <Blur Handler="out_text('txtHandle3')" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" align="left" valign="top">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" valign="top">
                            </td>
                        </tr>
                    </table>
                    <table width="953px" border="0" cellpadding="0" cellspacing="0" style=" position:relative;">
                        <tr>
                            <td rowspan="2" width="51" align="center" valign="top" bgcolor="#FFFFFF" class="boder_line boder_line_07"
                                id="Td1" style="padding-top: 5px; line-height: 15px">
                                No. of<br />
                                Pieces<br />
                                RCP
                            </td>
                            <td rowspan="2" width="78" align="center" valign="top" bgcolor="#FFFFFF" class="boder_line boder_line_07"
                                id="Td2" style="padding-top: 5px; line-height: 20px">
                                Gross<br />
                                Weight
                            </td>
                            <td rowspan="2" valign="top" bgcolor="#FFFFFF" class="boder_line" style="padding-bottom: 5px;
                                padding-top: 7px; font-size: 8px; line-height: 18px">
                                kg<br />
                                lb
                            </td>
                            <td width="7px" rowspan="2" align="left" valign="top" bgcolor="#eeeeee" class="boder_line_06 boder_line_02 ae_table"
                                style="padding-left: 2px">
                                &nbsp;
                            </td>
                            <td colspan="2" valign="top" bgcolor="#FFFFFF" class="boder_line_02" style="padding-left: 2px;
                                padding-right: 2px; padding-top: 5px;" id="Td3">
                                Rate Class
                            </td>
                            <td width="1px" rowspan="2" align="left" valign="top" bgcolor="#eeeeee" class="boder_line_06 boder_line_02 ae_table"
                                style="padding-left: 4px">
                                &nbsp;
                            </td>
                            <td rowspan="2" align="center" valign="top" bgcolor="#FFFFFF" id="Td4" class="boder_line_07 boder_line_02"
                                style="padding-top: 2px; line-height: 20px">
                                Chargeable<br />
                                Weight
                            </td>
                            <td width="5" rowspan="2" align="left" valign="top" bgcolor="#eeeeee" class="boder_line_06 boder_line_02 ae_table"
                                style="padding-left: 2px">
                                &nbsp;
                            </td>
                            <td rowspan="2" align="Center" valign="top" bgcolor="#FFFFFF" class="boder_line_07 boder_line_02">
                                <img src="../../images/table/title_03.jpg" />
                            </td>
                            <td width="10px" rowspan="2" align="left" valign="top" bgcolor="#eeeeee" class="boder_line_06 boder_line_02 ae_table"
                                style="padding-left: 2px">
                                &nbsp;
                            </td>
                            <td rowspan="2" align="center" valign="top" bgcolor="#FFFFFF" id="Td5" class="boder_line_07 boder_line_02"
                                style="padding-top: 5px">
                                 <table border="0" cellpadding="0" cellspacing="0"  width="100%">
                                    <tr>
                                        <td align="center">Total </td>
                                        <td style="padding-top: 2px" align="right"  width="47">
                                            <img src="../../images/table/mark.jpg" id="img_Mark" runat="server"  height="16" onclick="showMark();"  style="display:none; position:absolute;top:3px; cursor:pointer;"/>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="11px" rowspan="2" valign="top" bgcolor="#eeeeee" class="boder_line_06 boder_line_02 ae_table">
                            </td>
                            <td rowspan="2" align="center" valign="top" bgcolor="#FFFFFF" class=" boder_line_02 boder_line_07"
                                style="padding-top: 5px; line-height: 15px">
                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                    <tr>
                                        <td >
                                            Nature and Quantity of Goods<br />
                                            (inc. Dimensions or Volume)
                                        </td>
                                        <td style="padding-top: 2px" align="right" width="80">
                                            <img src="../../images/table/D.jpg" id="img_Dimension" runat="server"  height="16" onclick="CompanyX.ShowDimension()"  style="display:block; position:absolute;top:3px; right:20px; cursor:pointer;"/>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td rowspan="2" class="boder_line_09 boder_line_07" style="padding-right: 20px">
                            </td>
                            <td width="20px" rowspan="2" align="center" valign="top" bgcolor="#FFFFFF">
                            </td>
                        </tr>
                        <tr>
                            <td width="7px" height="32" valign="top" bgcolor="#FFFFFF" class="font_11bold ae_table">
                                &nbsp;
                            </td>
                            <td valign="top" bgcolor="#FFFFFF" class="boder_line_02 boder_line_04 boder_line_07"
                                style="line-height: 12px; padding-left: 4px">
                                Commodity
                                <br />
                                Item No.
                            </td>
                        </tr>
                        <tr>
                            <td width="52px" valign="top" bgcolor="#FFFFFF" class="font_11bold boder_line_04 ae_table"
                                style="padding-left: 1px">
                                <ext:NumberField ID="txtRCP1" Cls="text_45" TabIndex="44" runat="server" Width="50"
                                    DecimalPrecision="0" StyleSpec="text-align:right">
                                    <Listeners>
                                        <Focus Handler="over_text('txtRCP1')" />
                                        <Blur Handler="out_text('txtRCP1')" />
                                    </Listeners>
                                </ext:NumberField>
                            </td>
                            <td valign="top" align="left" bgcolor="#FFFFFF" class="font_11bold ae_table">
                                <ext:TextField ID="txtGWT1" Cls="text_45" TabIndex="45" runat="server" Width="78"
                                    StyleSpec="text-align:right">
                                    <Listeners>
                                        <Focus Handler="over_text('txtGWT1')" />
                                        <Blur Handler="out_text('txtGWT1');FormatNum(this,3);SetRate();" />
                                        <Change Handler="vwt(this);sumTotal();CheckList();" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                            <td align="left" valign="top" bgcolor="#FFFFFF" class="font_11bold ae_table boder_line_04">
                                <ext:TextField ID="txtUnit1" Cls="text_45" TabIndex="46" runat="server" Width="8"
                                    MaxLength="3">
                                    <Listeners>
                                        <Focus Handler="over_text('txtUnit1')" />
                                        <Blur Handler="out_text('txtUnit1')" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                            <td colspan="2" valign="top" align="left" class="font_11bold ae_table" style="background-image: url(../../images/table/gray_00.jpg);
                                background-position: left; background-repeat: repeat-y">
                                <ext:TextField ID="txtRateClass1" Cls="text_45" TabIndex="47" runat="server" Width="20px"
                                    MaxLength="2">
                                    <Listeners>
                                        <Focus Handler="over_text('txtRateClass1')" />
                                        <Blur Handler="out_text('txtRateClass1')" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                            <td colspan="2" align="left" valign="top" class="boder_line_04 ae_table" style="background-image: url(../../images/table/gray_00.jpg);
                                background-position: right; background-repeat: repeat-y">
                                <ext:TextField ID="txtItem1" Cls="text_45" TabIndex="48" runat="server" Width="92"
                                    MaxLength="9">
                                    <Listeners>
                                        <Focus Handler="over_text('txtItem1')" />
                                        <Blur Handler="out_text('txtItem1')" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                            <td colspan="2" align="left" valign="top" bgcolor="#FFFFFF" class="font_11bold ae_table"
                                style="background-image: url(../../images/table/gray_00.jpg); background-position: right;
                                background-repeat: repeat-y">
                                <table cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td style="width: 88px">
                                            <ext:TextField ID="txtCWT1" Cls="text_45" TabIndex="49" runat="server" Width="87"
                                                StyleSpec="text-align:right;margin-right:3px">
                                                <Listeners>
                                                    <Focus Handler="over_text('txtCWT1')" />
                                                    <Blur Handler="out_text('txtCWT1');FormatNum(this,3);SetRate();" />
                                                    <Change Handler="sumTotal();CheckList();" />
                                                </Listeners>
                                            </ext:TextField>
                                            <ext:TextField ID="txtVWT" runat="server" Hidden="true">
                                            </ext:TextField>
                                        </td>
                                        <td valign="middle" class="x-form-text x-form-field text_45">
                                            <span class="text_45">K</span>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td colspan="2" valign="top" align="left" bgcolor="#FFFFFF" class="font_11bold ae_table"
                                style="background-image: url(../../images/table/gray_00.jpg); background-position: right;
                                width: 108px; background-repeat: repeat-y">
                                <ext:TextField ID="txtRate1" Cls="text_45" TabIndex="50" runat="server" Width="100"
                                    StyleSpec="text-align:right;margin-right:8px;">
                                    <Listeners>
                                        <Focus Handler="over_text('txtRate1')" />
                                        <Blur Handler="out_text('txtRate1');FormatNum(this,3);" />
                                        <Change Handler="sumTotal();CheckList();" />
                                    </Listeners>
                                </ext:TextField>
                                <ext:TextField ID="txtRate2" runat="server" Width="113" Hidden="true" Disabled="true"
                                    Cls="text_45" Text="AS ARRANGE">
                                </ext:TextField>
                            </td>
                            <td valign="top" align="left" bgcolor="#FFFFFF">
                                <table cellpadding="0" cellspacing="0" border="0" width="145">
                                    <tr>
                                        <td>
                                            <ext:TextField ID="txtTotal1" Cls="text_45" TabIndex="51" runat="server" Width="145"
                                                StyleSpec="text-align:right">
                                                <Listeners>
                                                    <Focus Handler="over_text('txtTotal1')" />
                                                    <Blur Handler="out_text('txtTotal1');" />
                                                    <Change Handler="FormatNum(this,2);CheckList();" />
                                                </Listeners>
                                            </ext:TextField>
                                            <ext:TextField ID="txtTotal11" runat="server" Cls="text_45" Width="145" Disabled="true"
                                                Hidden="true">
                                            </ext:TextField>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="300" colspan="2" align="left" valign="top" bgcolor="#FFFFFF" class="ae_table"
                                style="background-image: url(../../images/table/gray.jpg); background-position: left;
                                background-repeat: repeat-y; border-left: 1px solid #000000">
                                <ext:TextField ID="txtLine1" Cls="text_45" TabIndex="65" runat="server" Width="295"
                                    EnableKeyEvents="true" MaxLength="28">
                                    <Listeners>
                                        <Focus Handler="over_text('txtLine1')" />
                                        <Blur Handler="out_text('txtLine1')" />
                                        <KeyDown Handler="ShowDimensions();" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                            <td align="right" style="padding-right: 4px" class="font_10_gray boder_line_05 " width="18">
                                01
                            </td>
                        </tr>
                        <tr>
                            <td colspan="12" valign="top" bgcolor="#FFFFFF" class="font_11bold boder_line_04 ae_table"
                                id="Td7" style="background-image: url('../../images/table/gray_01.jpg'); padding-left: 1px">
                                <ext:TextField ID="txtLineAll1"  EnableKeyEvents="true"  Cls="text_45" TabIndex="52" runat="server" Width="610"
                                    MaxLength="61">
                                    <Listeners>
                                        <Focus Handler="over_text('txtLineAll1')" />
                                        <Blur Handler="out_text('txtLineAll1')" />
                                        <KeyDown Handler="ShowDescription();" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                            <td colspan="2" align="left" valign="top" bgcolor="#FFFFFF" class="ae_table" style="line-height: 15px;
                                background-image: url(../../images/table/gray.jpg); background-position: left;
                                background-repeat: repeat-y; border-left: 1px solid #000000">
                                <ext:TextField ID="txtLine2" Cls="text_45" TabIndex="66" runat="server" Width="297"
                                    MaxLength="28" EnableKeyEvents="true">
                                    <Listeners>
                                        <Focus Handler="over_text('txtLine2')" />
                                        <Blur Handler="out_text('txtLine2')" />
                                        <KeyDown Handler="ShowDimensions();" />
                                    </Listeners>
                                </ext:TextField>
                                <td align="right" style="padding-right: 4px" class="font_10_gray boder_line_05">
                                    02
                                </td>
                        </tr>
                        <tr>
                            <td colspan="12" valign="top" bgcolor="#FFFFFF" class="font_11bold boder_line_04 ae_table"
                                id="Td9" style="background-image: url('../../images/table/gray_01.jpg'); padding-left: 1px">
                                <table cellpadding="0" cellspacing="0" border="0" width="">
                                    <tr>
                                        <td>
                                            <ext:TextField ID="txtLineAll2" EnableKeyEvents="true"  Cls="text_45" TabIndex="53" runat="server" Width="610"
                                                MaxLength="61">
                                                <Listeners>
                                                    <Focus Handler="over_text('txtLineAll2')" />
                                                    <Blur Handler="out_text('txtLineAll2')" />
                                                    <KeyDown Handler="ShowDescription();" />
                                                </Listeners>
                                            </ext:TextField>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td colspan="2" align="left" valign="top" bgcolor="#FFFFFF" class="ae_table" style="line-height: 15px;
                                background-image: url(../../images/table/gray.jpg); background-position: left;
                                background-repeat: repeat-y; border-left: 1px solid #000000">
                                <ext:TextField ID="txtLine3" Cls="text_45" TabIndex="67" runat="server" Width="297"
                                    MaxLength="28" EnableKeyEvents="true">
                                    <Listeners>
                                        <Focus Handler="over_text('txtLine3')" />
                                        <Blur Handler="out_text('txtLine3')" />
                                        <KeyDown Handler="ShowDimensions();" />
                                    </Listeners>
                                </ext:TextField>
                                <td align="right" style="padding-right: 4px" class="font_10_gray boder_line_05">
                                    03
                                </td>
                        </tr>
                        <tr>
                            <td colspan="12" valign="top" bgcolor="#FFFFFF" class="font_11bold boder_line_04 ae_table"
                                style="background-image: url('../../images/table/gray_01.jpg'); padding-left: 1px;
                                background-repeat: repeat-y">
                                <ext:TextField ID="txtLineAll3" EnableKeyEvents="true"  Cls="text_45" TabIndex="54" runat="server" Width="610"
                                    MaxLength="61">
                                    <Listeners>
                                        <Focus Handler="over_text('txtLineAll3')" />
                                        <Blur Handler="out_text('txtLineAll3')" />
                                        <KeyDown Handler="ShowDescription();" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                            <td colspan="2" align="left" valign="top" bgcolor="#FFFFFF" id="Td12" class="ae_table"
                                style="line-height: 15px; background-image: url(../../images/table/gray.jpg);
                                background-position: left; background-repeat: repeat-y; border-left: 1px solid #000000">
                                <ext:TextField ID="txtLine4" Cls="text_45" TabIndex="68" runat="server" Width="297"
                                    MaxLength="28" EnableKeyEvents="true">
                                    <Listeners>
                                        <Focus Handler="over_text('txtLine4')" />
                                        <Blur Handler="out_text('txtLine4')" />
                                        <KeyDown Handler="ShowDimensions();" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                            <td class="font_10_gray boder_line_05" style="padding-right: 4px" align="right">
                                04
                            </td>
                        </tr>
                        <tr>
                            <td colspan="12" valign="top" bgcolor="#FFFFFF" class="font_11bold boder_line_04 ae_table"
                                id="Td13" style="background-image: url('../../images/table/gray_01.jpg'); padding-left: 1px">
                                <ext:TextField ID="txtLineAll4" EnableKeyEvents="true"  Cls="text_45" TabIndex="55" runat="server" Width="610"
                                    MaxLength="61">
                                    <Listeners>
                                        <Focus Handler="over_text('txtLineAll4')" />
                                        <Blur Handler="out_text('txtLineAll4')" />
                                        <KeyDown Handler="ShowDescription();" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                            <td colspan="2" align="left" valign="top" bgcolor="#FFFFFF" id="Td14" class="ae_table"
                                style="line-height: 15px; background-image: url(../../images/table/gray.jpg);
                                background-position: left; background-repeat: repeat-y; border-left: 1px solid #000000">
                                <ext:TextField ID="txtLine5" Cls="text_45" TabIndex="69" runat="server" Width="297"
                                    MaxLength="28" EnableKeyEvents="true">
                                    <Listeners>
                                        <Focus Handler="over_text('txtLine5')" />
                                        <Blur Handler="out_text('txtLine5')" />
                                        <KeyDown Handler="ShowDimensions();" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                            <td class="font_10_gray boder_line_05" style="padding-right: 4px" align="right">
                                05
                            </td>
                </td>
            </tr>
            <tr>
                <td colspan="12" valign="top" bgcolor="#FFFFFF" class="font_11bold boder_line_04 ae_table"
                    id="Td15" style="background-image: url('../../images/table/gray_01.jpg'); padding-left: 1px">
                    <ext:TextField ID="txtLineAll5"  EnableKeyEvents="true"  Cls="text_45" TabIndex="56" runat="server" Width="610"
                        MaxLength="61">
                        <Listeners>
                            <Focus Handler="over_text('txtLineAll5')" />
                            <Blur Handler="out_text('txtLineAll5')" />
                            <KeyDown Handler="ShowDescription();" />
                        </Listeners>
                    </ext:TextField>
                </td>
                <td colspan="2" align="left" valign="top" bgcolor="#FFFFFF" id="Td16" class="ae_table"
                    style="line-height: 15px; background-image: url(../../images/table/gray.jpg);
                    background-position: left; background-repeat: repeat-y; border-left: 1px solid #000000">
                    <ext:TextField ID="txtLine6" Cls="text_45" TabIndex="70" runat="server" Width="297"
                        MaxLength="28" EnableKeyEvents="true">
                        <Listeners>
                            <Focus Handler="over_text('txtLine6')" />
                            <Blur Handler="out_text('txtLine6')" />
                            <KeyDown Handler="ShowDimensions();" />
                        </Listeners>
                    </ext:TextField>
                </td>
                <td style="padding-right: 4px" class="font_10_gray boder_line_05" align="right">
                    06
                </td>
            </tr>
            <tr>
                <td colspan="12" valign="top" bgcolor="#FFFFFF" class="font_11bold boder_line_04 ae_table"
                    id="Td17" style="background-image: url('../../images/table/gray_01.jpg'); padding-left: 1px">
                    <ext:TextField ID="txtLineAll6"  EnableKeyEvents="true"  Cls="text_45" TabIndex="57" runat="server" Width="610"
                        MaxLength="61">
                        <Listeners>
                            <Focus Handler="over_text('txtLineAll6')" />
                            <Blur Handler="out_text('txtLineAll6')" />
                            <KeyDown Handler="ShowDescription();" />
                        </Listeners>
                    </ext:TextField>
                </td>
                <td colspan="2" align="left" valign="top" bgcolor="#FFFFFF" id="Td18" class="ae_table"
                    style="line-height: 15px; background-image: url(../../images/table/gray.jpg);
                    background-position: left; background-repeat: repeat-y; border-left: 1px solid #000000">
                    <ext:TextField ID="txtLine7" Cls="text_45" TabIndex="71" runat="server" Width="297"
                        MaxLength="28" EnableKeyEvents="true">
                        <Listeners>
                            <Focus Handler="over_text('txtLine7')" />
                            <Blur Handler="out_text('txtLine7')" />
                            <KeyDown Handler="ShowDimensions();" />
                        </Listeners>
                    </ext:TextField>
                </td>
                <td style="padding-right: 4px" align="right" class="font_10_gray boder_line_05">
                    07
                </td>
            </tr>
            <tr>
                <td colspan="12" valign="top" bgcolor="#FFFFFF" class="font_11bold boder_line_04 ae_table"
                    id="Td19" style="background-image: url('../../images/table/gray_01.jpg'); padding-left: 1px">
                    <ext:TextField ID="txtLineAll7" EnableKeyEvents="true"  Cls="text_45" TabIndex="58" runat="server" Width="610"
                        MaxLength="61">
                        <Listeners>
                            <Focus Handler="over_text('txtLineAll7')" />
                            <Blur Handler="out_text('txtLineAll7')" />
                            <KeyDown Handler="ShowDescription();" />
                        </Listeners>
                    </ext:TextField>
                </td>
                <td colspan="2" align="left" valign="top" bgcolor="#FFFFFF" id="Td20" class="ae_table"
                    style="line-height: 15px; background-image: url(../../images/table/gray.jpg);
                    background-position: left; background-repeat: repeat-y; border-left: 1px solid #000000">
                    <ext:TextField ID="txtLine8" Cls="text_45" TabIndex="72" runat="server" Width="297"
                        MaxLength="28" EnableKeyEvents="true">
                        <Listeners>
                            <Focus Handler="over_text('txtLine8')" />
                            <Blur Handler="out_text('txtLine8')" />
                            <KeyDown Handler="ShowDimensions();" />
                        </Listeners>
                    </ext:TextField>
                </td>
                <td style="padding-right: 4px" align="right" class="font_10_gray boder_line_05">
                    08
                </td>
            </tr>
            <tr>
                <td colspan="12" valign="top" bgcolor="#FFFFFF" class="font_11bold boder_line_04 ae_table"
                    id="Td21" style="background-image: url('../../images/table/gray_01.jpg'); padding-left: 1px">
                    <ext:TextField ID="txtLineAll8"  EnableKeyEvents="true"  Cls="text_45" TabIndex="59" runat="server" Width="610"
                        MaxLength="61">
                        <Listeners>
                            <Focus Handler="over_text('txtLineAll8')" />
                            <Blur Handler="out_text('txtLineAll8')" />
                            <KeyDown Handler="ShowDescription();" />
                        </Listeners>
                    </ext:TextField>
                </td>
                <td colspan="2" align="left" valign="top" bgcolor="#FFFFFF" id="Td22" class="ae_table"
                    style="line-height: 15px; background-image: url(../../images/table/gray.jpg);
                    background-position: left; background-repeat: repeat-y; border-left: 1px solid #000000">
                    <ext:TextField ID="txtLine9" Cls="text_45" TabIndex="73" runat="server" Width="297"
                        MaxLength="28" EnableKeyEvents="true">
                        <Listeners>
                            <Focus Handler="over_text('txtLine9')" />
                            <Blur Handler="out_text('txtLine9')" />
                            <KeyDown Handler="ShowDimensions();" />
                        </Listeners>
                    </ext:TextField>
                </td>
                <td class="font_10_gray boder_line_05" style="padding-right: 4px" align="right">
                    09
                </td>
            </tr>
            <tr>
                <td colspan="12" valign="top" bgcolor="#FFFFFF" class="font_11bold boder_line_04 ae_table"
                    id="Td23" style="background-image: url('../../images/table/gray_01.jpg'); padding-left: 1px">
                    <ext:TextField ID="txtLineAll9"  EnableKeyEvents="true"  Cls="text_45" TabIndex="60" runat="server" Width="610"
                        MaxLength="61">
                        <Listeners>
                            <Focus Handler="over_text('txtLineAll9')" />
                            <Blur Handler="out_text('txtLineAll9')" />
                            <KeyDown Handler="ShowDescription();" />
                        </Listeners>
                    </ext:TextField>
                </td>
                <td colspan="2" align="left" valign="top" bgcolor="#FFFFFF" id="Td24" class="ae_table"
                    style="line-height: 15px; background-image: url(../../images/table/gray.jpg);
                    background-position: left; background-repeat: repeat-y; border-left: 1px solid #000000">
                    <ext:TextField ID="txtLine10" Cls="text_45" TabIndex="74" runat="server" Width="297" MaxLength="28"
                        EnableKeyEvents="true">
                        <Listeners>
                            <Focus Handler="over_text('txtLine10')" />
                            <Blur Handler="out_text('txtLine10')" />
                            <KeyDown Handler="ShowDimensions();" />
                        </Listeners>
                    </ext:TextField>
                </td>
                <td style="padding-right: 4px" align="right" class="font_10_gray boder_line_05">
                    10
                </td>
            </tr>
            <tr>
                <td colspan="12" valign="top" bgcolor="#FFFFFF" class="font_11bold boder_line_04 ae_table"
                    id="Td25" style="background-image: url('../../images/table/gray_01.jpg'); padding-left: 1px">
                    <ext:TextField ID="txtLineAll10"  EnableKeyEvents="true"  Cls="text_45" TabIndex="61" runat="server" Width="610"
                        MaxLength="61">
                        <Listeners>
                            <Focus Handler="over_text('txtLineAll10')" />
                            <Blur Handler="out_text('txtLineAll10')" />
                            <KeyDown Handler="ShowDescription();" />
                        </Listeners>
                    </ext:TextField>
                </td>
                <td colspan="2" align="left" valign="top" bgcolor="#FFFFFF" id="Td26" class="ae_table"
                    style="line-height: 15px; background-image: url(../../images/table/gray.jpg);
                    background-position: left; background-repeat: repeat-y; border-left: 1px solid #000000">
                    <ext:TextField ID="txtLine11" Cls="text_45" TabIndex="75" runat="server" Width="297" MaxLength="28"
                        EnableKeyEvents="true">
                        <Listeners>
                            <Focus Handler="over_text('txtLine11')" />
                            <Blur Handler="out_text('txtLine11')" />
                            <KeyDown Handler="ShowDimensions();" />
                        </Listeners>
                    </ext:TextField>
                </td>
                <td style="padding-right: 4px" class="font_10_gray boder_line_05" align="right">
                    11
                </td>
            </tr>
            <tr>
                <td colspan="12" valign="top" bgcolor="#FFFFFF" class="font_11bold boder_line_04 ae_table"
                    id="Td27" style="background-image: url('../../images/table/gray_01.jpg'); padding-left: 1px">
                    <ext:TextField ID="txtLineAll11"  EnableKeyEvents="true"  Cls="text_45" TabIndex="62" runat="server" Width="610"
                        MaxLength="61">
                        <Listeners>
                            <Focus Handler="over_text('txtLineAll11')" />
                            <Blur Handler="out_text('txtLineAll11')" />
                            <KeyDown Handler="ShowDescription();" />
                        </Listeners>
                    </ext:TextField>
                </td>
                <td colspan="2" align="left" valign="top" bgcolor="#FFFFFF" id="Td28" class="ae_table"
                    style="line-height: 15px; background-image: url(../../images/table/gray.jpg);
                    background-position: left; background-repeat: repeat-y; border-left: 1px solid #000000">
                    <ext:TextField ID="txtLine12" Cls="text_45" TabIndex="76" runat="server" Width="297" MaxLength="28"
                        EnableKeyEvents="true">
                        <Listeners>
                            <Focus Handler="over_text('txtLine12')" />
                            <Blur Handler="out_text('txtLine12')" />
                            <KeyDown Handler="ShowDimensions();" />
                        </Listeners>
                    </ext:TextField>
                </td>
                <td style="padding-right: 4px" align="right" class="font_10_gray boder_line_05">
                    12
                </td>
            </tr>
            <tr>
                <td colspan="12" valign="top" bgcolor="#FFFFFF" class="font_11bold boder_line_04 ae_table"
                    id="Td29" style="background-image: url('../../images/table/gray_01.jpg'); padding-left: 1px">
                    <ext:TextField ID="txtLineAll12"  EnableKeyEvents="true"  Cls="text_45" TabIndex="63" runat="server" Width="610"
                        MaxLength="61">
                        <Listeners>
                            <Focus Handler="over_text('txtLineAll12')" />
                            <Blur Handler="out_text('txtLineAll12')" />
                            <KeyDown Handler="ShowDescription();" />
                        </Listeners>
                    </ext:TextField>
                </td>
                <td colspan="2" align="left" valign="top" bgcolor="#FFFFFF" id="Td30" class="ae_table"
                    style="line-height: 15px; background-image: url(../../images/table/gray.jpg);
                    background-position: left; background-repeat: repeat-y; border-left: 1px solid #000000">
                    <ext:TextField ID="txtLine13" Cls="text_45" TabIndex="77" runat="server" Width="297" MaxLength="28"
                        EnableKeyEvents="true">
                        <Listeners>
                            <Focus Handler="over_text('txtLine13')" />
                            <Blur Handler="out_text('txtLine13')" />
                            <KeyDown Handler="ShowDimensions();" />
                        </Listeners>
                    </ext:TextField>
                </td>
                <td class="font_10_gray boder_line_05" style="padding-right: 4px" align="right">
                    13
                </td>
            </tr>
            <tr>
                <td colspan="12" valign="top" bgcolor="#FFFFFF" class="font_11bold boder_line_04 ae_table"
                    id="Td31" style="background-image: url('../../images/table/gray_01.jpg'); padding-left: 1px">
                    <ext:TextField ID="txtLineAll13"  EnableKeyEvents="true"  Cls="text_45" TabIndex="64" runat="server" Width="615"
                        MaxLength="61">
                        <Listeners>
                            <Focus Handler="over_text('txtLineAll13')" />
                            <Blur Handler="out_text('txtLineAll13')" />
                            <KeyDown Handler="ShowDescription();" />
                        </Listeners>
                    </ext:TextField>
                </td>
                <td colspan="2" align="left" valign="top" bgcolor="#FFFFFF" id="Td32" class="ae_table"
                    style="line-height: 15px; background-image: url(../../images/table/gray.jpg);
                    background-position: left; background-repeat: repeat-y; border-left: 1px solid #000000">
                    <ext:TextField ID="txtLine14" Cls="text_45" TabIndex="78" runat="server" Width="297"  MaxLength="28"
                        EnableKeyEvents="true">
                        <Listeners>
                            <Focus Handler="over_text('txtLine14')" />
                            <Blur Handler="out_text('txtLine14')" />
                            <KeyDown Handler="ShowDimensions();" />
                        </Listeners>
                    </ext:TextField>
                </td>
                <td style="padding-right: 4px" align="right" class="font_10_gray boder_line_05">
                    14
                </td>
            </tr>
        </table>
        <table width="934px" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td colspan="2" align="center" valign="top" class="boder_line">
                    <table cellpadding="0" cellspacing="0" border="0" width="345px">
                        <tr>
                            <td>
                                <img src="../../images/table/title_05.jpg" />
                            </td>
                        </tr>
                    </table>
                </td>
                <td colspan="3" valign="top" class="boder_line boder_line_05" style="padding-left: 5px">
                                Other Charges
                                <img src="../../images/table/other.jpg" id="img_otherCharges" runat="server"  height="16" onclick="CompanyX.ShowOtherChargs()" onmouseover="this.style.cursor='pointer';" style="float:right; margin:2px 4px 0 0" />
                </td>
            </tr>
            <tr>
                <td width="172" valign="top" class="boder_line_04 ae_table" id="padding03">
                    <ext:TextField ID="txtPPWeight" Cls="text_45" TabIndex="79" runat="server" Width="170"
                        StyleSpec="text-align:center">
                        <Listeners>
                            <Focus Handler="over_text('txtPPWeight')" />
                            <Blur Handler="out_text('txtPPWeight');" />
                            <Change Handler="FormatNum(this,2);TotalPP();" />
                        </Listeners>
                    </ext:TextField>
                    <ext:TextField ID="txtPPWeight1" runat="server" Cls="text_45" Width="170" Hidden="true"
                        Disabled="true" Text="AS ARRANGE">
                    </ext:TextField>
                </td>
                <td width="172" valign="top" class="boder_line_04 ae_table" id="padding03">
                    <ext:TextField ID="txtCCWeight" Cls="text_45" TabIndex="85" runat="server" Width="170"
                        StyleSpec="text-align:center">
                        <Listeners>
                            <Focus Handler="over_text('txtCCWeight')" />
                            <Blur Handler="out_text('txtCCWeight');" />
                            <Change Handler="FormatNum(this,2);TotalCC();" />
                        </Listeners>
                    </ext:TextField>
                    <ext:TextField ID="txtCCWeight1" runat="server" Cls="text_45" Width="170" Hidden="true"
                        Disabled="true" Text="AS ARRANGE">
                    </ext:TextField>
                </td>
                <td colspan="3" valign="top" class="boder_line_06 ae_table" id="padding03">
                    <ext:TextField ID="txtOtherCharges1" Cls="text_45" TabIndex="101" runat="server"
                        Width="587" MaxLength="56">
                        <Listeners>
                            <Focus Handler="over_text('txtOtherCharges1')" />
                            <Blur Handler="out_text('txtOtherCharges1')" />
                        </Listeners>
                    </ext:TextField>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center" valign="top" class="boder_line">
                    <img src="../../images/table/title_06.jpg" />
                </td>
                <td colspan="3" valign="top" class="boder_line_06 ae_table" id="padding03">
                    <ext:TextField ID="txtOtherCharges2" Cls="text_45" TabIndex="102" runat="server"
                        Width="587" MaxLength="56">
                        <Listeners>
                            <Focus Handler="over_text('txtOtherCharges2')" />
                            <Blur Handler="out_text('txtOtherCharges2')" />
                        </Listeners>
                    </ext:TextField>
                </td>
            </tr>
            <tr>
                <td valign="top" class="boder_line_04 ae_table" id="padding03">
                    <ext:TextField ID="txtPPValuation" Cls="text_45" TabIndex="80" runat="server" Width="170"
                        StyleSpec="text-align:center">
                        <Listeners>
                            <Focus Handler="over_text('txtPPValuation')" />
                            <Blur Handler="out_text('txtPPValuation');" />
                            <Change Handler="FormatNum(this,2);TotalPP();" />
                        </Listeners>
                    </ext:TextField>
                </td>
                <td valign="top" class="boder_line_04 ae_table" id="padding03">
                    <ext:TextField ID="txtCCValuation" Cls="text_45" TabIndex="86" runat="server" Width="170"
                        StyleSpec="text-align:center">
                        <Listeners>
                            <Focus Handler="over_text('txtCCValuation')" />
                            <Blur Handler="out_text('txtCCValuation');" />
                            <Change Handler="FormatNum(this,2);TotalCC();" />
                        </Listeners>
                    </ext:TextField>
                </td>
                <td colspan="3" valign="top" class="boder_line_06 ae_table" id="padding03">
                    <ext:TextField ID="txtOtherCharges3" Cls="text_45" TabIndex="103" runat="server"
                        Width="587" MaxLength="56">
                        <Listeners>
                            <Focus Handler="over_text('txtOtherCharges3')" />
                            <Blur Handler="out_text('txtOtherCharges3')" />
                        </Listeners>
                    </ext:TextField>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center" valign="top" class="boder_line">
                    <img src="../../images/table/title_07.jpg" />
                </td>
                <td colspan="3" valign="top" class="boder_line_06 ae_table" id="padding03">
                    <ext:TextField ID="txtOtherCharges4" Cls="text_45" TabIndex="104" runat="server"
                        Width="587" MaxLength="56">
                        <Listeners>
                            <Focus Handler="over_text('txtOtherCharges4')" />
                            <Blur Handler="out_text('txtOtherCharges4')" />
                        </Listeners>
                    </ext:TextField>
                </td>
            </tr>
            <tr>
                <td valign="top" class="boder_line_04 ae_table" id="padding03">
                    <ext:TextField ID="txtPPTax" Cls="text_45" TabIndex="81" runat="server" Width="170"
                        StyleSpec="text-align:center">
                        <Listeners>
                            <Focus Handler="over_text('txtPPTax')" />
                            <Blur Handler="out_text('txtPPTax');" />
                            <Change Handler="FormatNum(this,2);TotalPP();" />
                        </Listeners>
                    </ext:TextField>
                </td>
                <td valign="top" class="boder_line_04 ae_table" id="padding03">
                    <ext:TextField ID="txtCCTax" Cls="text_45" TabIndex="87" runat="server" Width="170"
                        StyleSpec="text-align:center">
                        <Listeners>
                            <Focus Handler="over_text('txtCCTax')" />
                            <Blur Handler="out_text('txtCCTax');" />
                            <Change Handler="FormatNum(this,2);TotalCC();" />
                        </Listeners>
                    </ext:TextField>
                </td>
                <td colspan="3" valign="top" class="boder_line_06 ae_table" id="padding03">
                    <ext:TextField ID="txtOtherCharges5" Cls="text_45" TabIndex="105" runat="server"
                        Width="587" MaxLength="56">
                        <Listeners>
                            <Focus Handler="over_text('txtOtherCharges5')" />
                            <Blur Handler="out_text('txtOtherCharges5')" />
                        </Listeners>
                    </ext:TextField>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center" valign="top" class="boder_line">
                    <img src="../../images/table/title_08.jpg" />
                </td>
                <td colspan="3" rowspan="4" valign="top" class="boder_line boder_line_05 font_11_gray_bold"
                    style="padding-left: 5px">
                    Shipper certifies...
                </td>
            </tr>
            <tr>
                <td valign="top" class="boder_line_04 ae_table" id="padding03">
                    <ext:TextField ID="txtPPOCAgent" Cls="text_45" TabIndex="82" runat="server" Width="170"
                        StyleSpec="text-align:center">
                        <Listeners>
                            <Focus Handler="over_text('txtPPOCAgent')" />
                            <Blur Handler="out_text('txtPPOCAgent');" />
                            <Change Handler="FormatNum(this,2);TotalPP();" />
                        </Listeners>
                    </ext:TextField>
                    <ext:TextField ID="txtPPOCAgent1" Cls="text_45" runat="server" Width="170" Disabled="true"
                        Text="AS ARRANGE" Hidden="true">
                    </ext:TextField>
                </td>
                <td valign="top" class="boder_line_04 ae_table" id="padding03">
                    <ext:TextField ID="txtCCOCAgent" Cls="text_45" TabIndex="88" runat="server" Width="170"
                        StyleSpec="text-align:center">
                        <Listeners>
                            <Focus Handler="over_text('txtCCOCAgent')" />
                            <Blur Handler="out_text('txtCCOCAgent');" />
                            <Change Handler="FormatNum(this,2);TotalCC();" />
                        </Listeners>
                    </ext:TextField>
                    <ext:TextField ID="txtCCOCAgent1" Cls="text_45" runat="server" Width="170" Disabled="true"
                        Text="AS ARRANGE" Hidden="true">
                    </ext:TextField>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center" valign="top" class="boder_line">
                    <img src="../../images/table/title_09.jpg" />
                </td>
            </tr>
            <tr>
                <td align="center" valign="top" class="boder_line_04 ae_table" id="padding03">
                    <ext:TextField ID="txtPPOCCarrier" Cls="text_45" TabIndex="83" runat="server" Width="170"
                        StyleSpec="text-align:center">
                        <Listeners>
                            <Focus Handler="over_text('txtPPOCCarrier')" />
                            <Blur Handler="out_text('txtPPOCCarrier');" />
                            <Change Handler="FormatNum(this,2);TotalPP();" />
                        </Listeners>
                    </ext:TextField>
                </td>
                <td align="left" valign="top" class="boder_line_04 ae_table" id="padding03">
                    <ext:TextField ID="txtCCOCCarrier" Cls="text_45" TabIndex="89" runat="server" Width="170"
                        StyleSpec="text-align:center">
                        <Listeners>
                            <Focus Handler="over_text('txtCCOCCarrier')" />
                            <Blur Handler="out_text('txtCCOCCarrier');" />
                            <Change Handler="FormatNum(this,2);TotalCC();" />
                        </Listeners>
                    </ext:TextField>
                </td>
            </tr>
            <tr>
                <td rowspan="2" align="center" valign="top" bgcolor="#CCCCCC" class="boder_line">
                    &nbsp;
                </td>
                <td rowspan="2" align="center" valign="top" bgcolor="#CCCCCC" class="boder_line">
                    &nbsp;
                </td>
                <td colspan="3" valign="top" class="boder_line_06 ae_table" id="padding03">
                    <ext:TextField ID="txtCert" Cls="text_45" TabIndex="106" runat="server" Width="587"
                        MaxLength="56" StyleSpec="text-align:center">
                        <Listeners>
                            <Focus Handler="over_text('txtCert')" />
                            <Blur Handler="out_text('txtCert')" />
                        </Listeners>
                    </ext:TextField>
                </td>
            </tr>
            <tr>
                <td colspan="3" align="center" valign="top" class="boder_line boder_line_05 font_11_gray">
                    Signature of Shipper or his Agent
                </td>
            </tr>
            <tr>
                <td align="center" valign="top" class="boder_line">
                    <img src="../../images/table/title_10.jpg" width="153" height="15" />
                </td>
                <td align="center" valign="top" class="boder_line">
                    <img src="../../images/table/title_11.jpg" width="153" height="15" />
                </td>
                <td colspan="3" valign="top" class="boder_line boder_line_05">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td valign="top" class="boder_line_04" id="padding03">
                    <ext:TextField ID="txtPPTotal" Cls="text_45" TabIndex="84" runat="server" Width="170"
                        StyleSpec="text-align:center">
                        <Listeners>
                            <Focus Handler="over_text('txtPPTotal')" />
                            <Blur Handler="out_text('txtPPTotal');" />
                            <Change Handler="FormatNum(this,2);" />
                        </Listeners>
                    </ext:TextField>
                    <ext:TextField ID="txtPPTotal1" runat="server" Cls="text_45" Width="170" Hidden="true"
                        Disabled="true" Text="AS ARRANGE">
                    </ext:TextField>
                </td>
                <td valign="top" class="boder_line_04" id="padding03">
                    <ext:TextField ID="txtCCTotal" Cls="text_45" TabIndex="100" runat="server" Width="170"
                        StyleSpec="text-align:center">
                        <Listeners>
                            <Focus Handler="over_text('txtCCTotal')" />
                            <Blur Handler="out_text('txtCCTotal')" />
                            <Change Handler="FormatNum(this,2);" />
                        </Listeners>
                    </ext:TextField>
                    <ext:TextField ID="txtCCTotal1" runat="server" Cls="text_45" Width="170" Hidden="true"
                        Disabled="true" Text="AS ARRANGE">
                    </ext:TextField>
                </td>
                <td colspan="3" valign="top" class="boder_line_06 ae_table" id="padding03">
                    <ext:TextField ID="txtSignature1" Cls="text_45" TabIndex="107" runat="server" Width="587"
                        MaxLength="56" StyleSpec="text-align:center">
                        <Listeners>
                            <Focus Handler="over_text('txtSignature1')" />
                            <Blur Handler="out_text('txtSignature1')" />
                        </Listeners>
                    </ext:TextField>
                </td>
            </tr>
            <tr>
                <td align="right" valign="top" class="boder_line">
                    <img src="../../images/table/title_12.jpg" width="167" height="15" />
                </td>
                <td align="left" valign="top" class="boder_line">
                    <img src="../../images/table/title_13.jpg" width="167" height="15" />
                </td>
                <td width="171" valign="top" class="boder_line ae_table" id="padding03">
                    <ext:TextField ID="txtSignDate" Cls="text_45" TabIndex="108" runat="server" Width="170"
                        StyleSpec="text-align:center">
                        <Listeners>
                            <Focus Handler="over_text('txtSignDate')" />
                            <Blur Handler="out_text('txtSignDate')" />
                        </Listeners>
                    </ext:TextField>
                </td>
                <td width="168" valign="top" class="boder_line ae_table" id="padding03">
                    <ext:TextField ID="txtSignStation" Cls="text_45" TabIndex="109" runat="server" Width="167"
                        MaxLength="14" StyleSpec="text-align:center">
                        <Listeners>
                            <Focus Handler="over_text('txtSignStation')" />
                            <Blur Handler="out_text('txtSignStation')" />
                        </Listeners>
                    </ext:TextField>
                </td>
                <td width="242" valign="top" class="boder_line boder_line_05 ae_table" id="padding03">
                    <ext:TextField ID="txtSignUser" Cls="text_45" TabIndex="110" runat="server" Width="240"
                        MaxLength="18" StyleSpec="text-align:center">
                        <Listeners>
                            <Focus Handler="over_text('txtSignUser')" />
                            <Blur Handler="out_text('txtSignUser')" />
                        </Listeners>
                    </ext:TextField>
                </td>
            </tr>
            <tr>
                <td valign="top" class="boder_line_04 ">
                    &nbsp;
                </td>
                <td valign="top" class="boder_line_04 ">
                    &nbsp;
                </td>
                <td valign="top" class="boder_line" style="padding-left: 10px">
                    <table width="165px" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="89" align="left">
                                Executed on
                            </td>
                            <td width="90" align="right">
                                (Date)
                            </td>
                        </tr>
                    </table>
                </td>
                <td align="center" valign="top" class="boder_line_02">
                    <table width="150" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="52" align="center">
                                at
                            </td>
                            <td width="98" align="right">
                                (Place)&nbsp;
                            </td>
                        </tr>
                    </table>
                </td>
                <td align="center" valign="top" class="boder_line_02 boder_line_05 ">
                    Signature of lssuing Carrier or its Agent
                </td>
            </tr>
            <tr>
                <td rowspan="2" align="center" valign="top" class="boder_line boder_line_07 ">
                    For Carrier's Use only<br />
                    at Destination
                </td>
                <td align="center" valign="top" class="boder_line ">
                    <img src="../../images/table/title_14.jpg" width="153" height="15" />
                </td>
                <td rowspan="2" align="center" valign="top" class="boder_line boder_line_07">
                    <img src="../../images/table/title_04.jpg" width="153" height="15" />
                </td>
                <td colspan="2" rowspan="2" valign="top" class="boder_line boder_line_05 boder_line_07">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td valign="top" class="boder_line_04 boder_line_07 ">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td colspan="5">
                    &nbsp;
                </td>
            </tr>
        </table>
        </td>
        <td width="22" valign="top" style="padding-top: 610px">
            &nbsp;
        </td>
        </tr>
        <tr>
            <td style="height: 10px">
            </td>
        </tr>
        </table>
        <ext:Container runat="server" ID="div_bottom">
        </ext:Container>
        <br />
    </div>
    <ext:Window runat="server" ID="windowconfirm" Title="Password" Modal="true" Padding="6" Hidden="true" 
        BodyBorder="false" Border="false" BodyStyle="background-color:#C6D4E4" Resizable="false" Width="250" 
        Height="110">
        <Items>
         <ext:Label ID="Label1" runat="server" Text=" Please enter your password:" StyleSpec="font-size:12px;"></ext:Label>
         <ext:TextField InputType="Password" EnableKeyEvents="true" AutoFocus="true"  runat="server" ID="txtpass" StyleSpec="border:inset 1px #D4D0C8; padding:1px 5px;width:225px;margin:5px 0; ">
            <Listeners>
                <KeyDown Handler="if(event.keyCode==13){ShowInput(txtpass.getValue());}" />
            </Listeners>
         </ext:TextField>
        </Items>      
        <Content>
            <table style="width:200px;">
                <tr>
                    <td>
                        <ext:Button runat="server" ID="Button1" Text="OK" Width="75px" StyleSpec="margin-left:32px;">
                            <Listeners>
                                <Click Handler="ShowInput(txtpass.getValue());" />                             
                            </Listeners>
                        </ext:Button>
                    </td>
                    <td>
                        <ext:Button runat="server" ID="btncancel" Text="Cancel" Width="75px">
                            <Listeners>
                                <Click Handler="#{windowconfirm}.hide();" />
                            </Listeners>
                        </ext:Button>
                    </td>                    
                </tr>
            </table>
        </Content>
        <Listeners>
            <Show Handler="setTimeout(function sssss(){txtpass.focus();},200);" />
        </Listeners>
    </ext:Window>
    </form>
</body>
</html>
