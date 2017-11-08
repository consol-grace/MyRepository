<%@ Page Language="C#" AutoEventWireup="true" CodeFile="detail.aspx.cs" Inherits="BasicData_Customer_detail" %>

<%@ Register Src="../../common/UIControls/UserComboBox.ascx" TagName="UserComboBox"
    TagPrefix="uc1" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Customer Detail</title>
    <link href="../../css/style.css" rel="stylesheet" type="text/css" />
    <script src="../../common/ylQuery/jQuery/js/jquery-1.4.1.js" type="text/javascript"></script>
    <script src="../../common/ylQuery/jQuery/js/jquery.ui.custom.js" type="text/javascript"></script>
    <script src="../../common/ylQuery/KeyListener.js" type="text/javascript"></script>
    <script type="text/javascript" src="Controller.js"></script>
    <script src="../AjaxServer/CheckField.js" type="text/javascript"></script>
    <script src="../AjaxServer/CheckCode.js" type="text/javascript"></script>
    <script type="text/javascript">

        $(function () {
            //$("#ChkSyncStat input").click(function () {

            //    var code = $("#hidChageCode").val();
            //    var stat = $(this).next("label").text()
            //    if (stat == "" || stat == null || stat == undefined) {
            //        return false;
            //    }
            //    if (code == null || code == "" || code == undefined) {
            //        Ext.Msg.alert('status', 'Please save the company information.');
            //        return false;
            //    }
            //    $(this).attr("checked", true);
            //    if ($(this).attr("checked")) {
            //        CompanyX.SyncCompany(stat);
            //    }
            //})

            $("#div_Sync").hover(function () { $(this).children("div").show(); }, function () { $(this).children("div").hide(); })
        })
    </script>
    <style type="text/css">
        .style1 {
            font-family: Verdana, Arial, Helvetica, sans-serif;
            font-size: 10px;
            color: #000000;
            height: 10px;
        }

        .style2 {
            height: 10px;
        }

        #ChkSyncStat input {
            margin: 0 8px;
            vertical-align: bottom;
            float: left;
            margin-top: 5px;
        }

        #ChkSyncStat label {
            margin-right: 15px;
            width: 55px;
            display: block;
            float: left;
        }
    </style>
    <style type="text/css">
        #ChkGrpStat label, #tblChkGroup label, #tblChkGroup_Container label {
            margin-right: 0px !important;
            margin-left: 2px !important;
        }

        #ChkGrpStat .x-form-check-wrap, #tblChkGroup .x-form-check-wrap, #tblChkGroup_Container .x-form-check-wrap {
            padding-top: 1px !important;
        }

        .x-form-check-wrap {
            line-height: 10px !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <ext:ResourceManager ID="ResourceManager1" runat="server" />
        <ext:KeyNav runat="server" ID="keyNav1" Target="#{form1}">
            <Esc Handler="window.parent.Window1.hide()" />
        </ext:KeyNav>
        <div id="countryControl">
            <div id="location_div01">
                <table width="580" border="0" cellspacing="0" cellpadding="0" style="padding-bottom: 30px;">
                    <tr>
                        <td class="table_25left_01">
                            <table width="622" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="315" align="left" valign="top" style="padding-left: 8px">
                                        <%-------%>
                                        <table style="width: 315" border="0" cellpadding="0" cellspacing="0" class="table_25left_01">
                                            <tr>
                                                <td class="font_11bold" style="padding-bottom: 5px;">
                                                    <span style="display: block; float: left; width: 50px;">Type</span><span class="font_red"
                                                        style="padding-right: 5px">*</span>
                                                </td>
                                                <td>
                                                    <ext:Store runat="server" ID="storeType">
                                                        <Reader>
                                                            <ext:JsonReader>
                                                                <Fields>
                                                                    <ext:RecordField Name="value">
                                                                    </ext:RecordField>
                                                                    <ext:RecordField Name="text">
                                                                    </ext:RecordField>
                                                                </Fields>
                                                            </ext:JsonReader>
                                                        </Reader>
                                                    </ext:Store>
                                                    <ext:ComboBox runat="server" ID="cmbType" StoreID="storeType" Width="108" Cls="select_160px"
                                                        Mode="Local" ForceSelection="true" TabIndex="1" ListWidth="320" ItemSelector="tr.list-item"
                                                        ValueField="value" DisplayField="text">
                                                        <Template runat="server">
                                                            <Html>
                                                                <tpl for=".">
                                                            <tpl if="[xindex] == 1">
                                                                <table class="cbStates-list">
                                                                    <tr>                                
                                                                        <th>Name</th>
                                                                        <th>Code</th>
                                                                    </tr>
                                                                    </tpl>
                                                                    <tr class="list-item">
                                                                        <td style="padding:3px 0px; width:70%">{text}</td>
                                                                        <td style="padding:3px 0px; width:30%">{value}</td>
                                                                    </tr>
                                                                    <tpl if="[xcount-xindex]==0">
                                        </table>
</tpl> </tpl>
</html>
</Template>
<listeners>                                                    
                                                    <Select Handler="ReadOnlyByType(this.value); CompanyX.ChangeTypeEidtCode();" />
                                                </listeners>
</ext:ComboBox>
<%--                                                <uc1:UserComboBox runat="server" ID="cmbType" StoreID="storeType" Width="108" isButton="false"
                                                    clsClass="select_160px" TabIndex="1" ListWidth="320" ItemSelector="tr.list-item"
                                                    Handler="ReadOnlyByType(this.value); CompanyX.ChangeTypeEidtCode();" />--%>
<ext:Hidden runat="server" ID="hidChangeType" Text="">
</ext:Hidden>
</td>
<td style="padding-left: 10px; display: none">Sales
</td>
<td style="display: none">
    <ext:Store runat="server" ID="storeSales">
        <Reader>
            <ext:JsonReader>
                <Fields>
                    <ext:RecordField Name="value">
                    </ext:RecordField>
                    <ext:RecordField Name="text">
                    </ext:RecordField>
                </Fields>
            </ext:JsonReader>
        </Reader>
    </ext:Store>
    <uc1:UserComboBox runat="server" ID="Sales" StoreID="storeSales" Width="120" isButton="false"
        clsClass="select_160px" TabIndex="2" winTitle="Sales" ListWidth="300" ItemSelector="tr.list-item" />
</td>
<td id="td_isvalid" runat="server">Active
</td>
<td style="padding-left: 6px">

    <ext:Checkbox ID="chkIsValid" runat="server" Checked="true" LabelWidth="0" FieldLabel="">
    </ext:Checkbox>
</td>
</tr>
<tr>
    <td class="font_11bold">
        <span style="display: block; float: left; width: 50px;">Code</span> <span class="font_red"
            style="padding-right: 5px">*</span>
    </td>
    <td style="padding-right: 30px;">
        <ext:TextField ID="Code" runat="server" Name="txtCode" TabIndex="3" Cls="select_160px"
            MaxLength="10" MinLength="2" Width="108" AllowBlank="false" EnableKeyEvents="true">
            <Listeners>
                <Blur Handler="checkCode('COMPANY','Code',#{hidRowID}.getValue());checkInputValue(this.id);" />
                <Focus Handler="CheckInputLen(true);" />
                <KeyUp Handler="removeClass('Code')" />
            </Listeners>
        </ext:TextField>
        <ext:Hidden ID="hidRowID" runat="server" Text="0">
        </ext:Hidden>
        <ext:Hidden ID="hidChageCode" runat="server" Text="">
        </ext:Hidden>
    </td>
    <td>
        <span style="display: block; float: left; width: 50px;">Location</span> <span class="font_red"
            style="padding-right: 5px;"></span>
    </td>
    <td style="padding-left: 6px">
        <ext:Store runat="server" ID="storeLocation">
            <Reader>
                <ext:JsonReader>
                    <Fields>
                        <ext:RecordField Name="value">
                        </ext:RecordField>
                        <ext:RecordField Name="text">
                        </ext:RecordField>
                    </Fields>
                </ext:JsonReader>
            </Reader>
        </ext:Store>
        <uc1:UserComboBox runat="server" ID="Location" StoreID="storeLocation" Width="88"
            isButton="false" clsClass="select_160px" TabIndex="4" winTitle="Location" winUrl="/BasicData/Location/list.aspx?sys="
            ListWidth="200" ItemSelector="tr.list-item" />
    </td>
</tr>
<%--2014-12-10 Grace--%>
<tr>
    <td class="font_11bold">
        <span style="display: block; float: left; width: 50px;">Request</span>
        <span class="font_red" style="padding-right: 5px">*</span>
    </td>
    <td style="padding-right: 30px;">
        <ext:Store runat="server" ID="storeFromUser">
            <Reader>
                <ext:JsonReader>
                    <Fields>
                        <ext:RecordField Name="value">
                        </ext:RecordField>
                        <ext:RecordField Name="text">
                        </ext:RecordField>
                    </Fields>
                </ext:JsonReader>
            </Reader>
        </ext:Store>
        <ext:ComboBox runat="server" ID="cmbFromUser" StoreID="storeFromUser" Width="108"
            Mode="Local" ForceSelection="true" Cls="select_160px" TabIndex="5" ValueField="text"
            DisplayField="text" ItemSelector="tr.list-item" ListWidth="200">

            <Template ID="Template1" runat="server">
                <Html>
                    <tpl for=".">
                                                            <tpl if="[xindex] == 1">
                                                                <table class="cbStates-list">
                                                                    <tr>                                
                                                                        <th>USER</th>
                                                                        <th>STAT</th>
                                                                    </tr>
                                                                    </tpl>
                                                                    <tr class="list-item">
                                                                        <td style="padding:3px 0px; width:60%">{text}</td>
                                                                        <td style="padding:3px 0px; width:40%">{value}</td>
                                                                    </tr>
                                                                    <tpl if="[xcount-xindex]==0">
                                                                   </table>
        </tpl> </tpl>
                </Html>
            </Template>
        </ext:ComboBox>
    </td>
    <td width="50" class="font_11bold" style="padding-right: 5px;">
        <table width="50" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td>Keyword
                </td>
            </tr>
        </table>
    </td>
    <td style="padding-left: 6px">
        <ext:TextField ID="geKeyword" runat="server" Cls="text_Courier" TabIndex="6" Width="108"
            Height="17">
        </ext:TextField>
    </td>
</tr>
<tr style="display: none">
    <td>US Code
    </td>
    <td style="padding-left: 6px">
        <ext:TextField ID="txtUsCode" runat="server" Cls="select_160px" Width="108" TabIndex="4">
        </ext:TextField>
    </td>
    <td></td>
    <td></td>
</tr>
</table>
<%-------%>
</td>
<td align="left">
    <table width="315" border="0" align="center" cellpadding="0" cellspacing="0" class="table_25left_01">
        <tr>
            <td align="right">
                <ext:Button runat="server" ID="Next" Cls="Submit_70px" Text="Next" Width="70px">
                    <DirectEvents>
                        <Click OnEvent="btnNext_Click">
                            <EventMask ShowMask="true" Msg=" Saving... " />
                        </Click>
                    </DirectEvents>
                </ext:Button>
            </td>
            <td align="center">
                <ext:Button runat="server" ID="Cancel" Cls="Submit_70px" Text="Cancel" Width="70px">
                    <DirectEvents>
                        <Click OnEvent="btnCancel_Click">
                            <EventMask ShowMask="true" Msg=" Loading... " />
                        </Click>
                    </DirectEvents>
                </ext:Button>
            </td>
            <td align="left">
                <ext:Button runat="server" ID="button" Cls="Submit_70px" Text="Save" Width="70px">
                    <Listeners>
                        <Click Handler="return Validata('Code')" />
                    </Listeners>
                    <DirectEvents>
                        <Click OnEvent="btnSave_Click">
                            <EventMask ShowMask="true" Msg=" Saving... " />
                        </Click>
                    </DirectEvents>
                </ext:Button>
            </td>
        </tr>
        <tr>
            <td colspan="3" height="2"></td>
        </tr>
        <tr>
            <td colspan="3" style="padding: 2px 0;">
                <table cellpadding="0" cellspacing="0" width="300px">
                    <tr>
                        <td style="text-align: center; padding-left:8px;" >
                            <label>Same Bill</label>
                        </td>
                        <td style="text-align: center">
                            <ext:Checkbox ID="chbBill" runat="server" FieldLabel="" Checked="true">
                                <Listeners>
                                    <Check Handler="if(this.checked){Copy('bi'); ReadOnly('BILLDisplay',true);}else{ReadOnly('BILLDisplay',false);}" />
                                </Listeners>
                            </ext:Checkbox>
                        </td>
                        <td style="text-align: center;" >
                            <label style="margin-left: 10px; display: block">Local Address</label>
                        </td>
                        <td style="text-align: center">
                            <ext:Checkbox ID="chbChinese" runat="server" FieldLabel="">
                                <Listeners>
                                    <Check Handler="if(this.checked){$('#div_china').show();}else{$('#div_china').hide();}" />
                                </Listeners>
                            </ext:Checkbox>
                        </td>

                        <td style="padding-left: 10px;" id="td_sales1">
                            <label>Sales code</label>
                        </td>
                        <td style="padding-left: 2px;" id="td_sales2">
                            <ext:Checkbox ID="chkIsSales" runat="server" LabelWidth="0" FieldLabel="">
                            </ext:Checkbox>
                        </td>

                        <%--2014-12-10 Grace--%>
                        <%--<td <%if (!((dep.ToUpper() == "ADMIN" || dep.ToUpper() == "IT")&&currStation=="Y")) { Response.Write("style='display:none'"); }  %>>--%>
                        <td <% Response.Write("style='display:none'"); %>>
                            <div style="position: relative; display: none" id="div_Sync">

                                <p style="background-image: url(/images/arrows_btn.png); background-repeat: no-repeat; background-position: right center; padding: 2px 5px; width: 45px; cursor: pointer;">
                                    Sync
                                </p>
                                <div style="position: absolute; z-index: 999; right: 0px; background-color: white; width: 300px; padding: 10px; border: solid 1px #DDD; display: none;">
                                    <%--<asp:checkboxlist id="ChkSyncStat" runat="server" repeatdirection="Horizontal" repeatlayout="Flow"></asp:checkboxlist>--%>
                                    <%--<ext:CheckboxGroup ID="tblChkGroup" runat="server"></ext:CheckboxGroup>--%>
                                </div>
                            </div>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="3" id="chkall" align="left" style="padding-left: 2px; display: none">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td>
                            <table width="44" border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td class="font_11bold" style="padding-left: 15px; padding-right: 3px">
                                        <input type="checkbox" runat="server" name="chkBILL" value="checkbox" id="chkBILL"
                                            onclick='ShowOne("BILL")' checked="checked" />
                                    </td>
                                    <td align="left" class="font_11bold">BILL
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <table width="34" border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td class="font_11bold" style="padding-left: 3px">
                                        <input type="checkbox" runat="server" name="chkAE" value="checkbox" id="chkAE" onclick='ShowOne("AE")' />
                                    </td>
                                    <td align="left" class="font_11bold">AE
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <table width="34" border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td class="font_11bold">
                                        <input type="checkbox" runat="server" name="chkOE" value="checkbox" id="chkOE" onclick='ShowOne("OE")' />
                                    </td>
                                    <td align="left" class="font_11bold">OE
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <table width="31" border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td class="font_11bold">
                                        <input type="checkbox" runat="server" name="chkAI" value="checkbox" id="chkAI" onclick='ShowOne("AI")' />
                                    </td>
                                    <td align="left" class="font_11bold">AI
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <table width="34" border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="20" class="font_11bold">
                                        <input type="checkbox" runat="server" name="chkOI" value="checkbox" id="chkOI" onclick='ShowOne("OI")' />
                                    </td>
                                    <td width="42" align="left" class="font_11bold">OI
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <%-- 2014-12-12 Grace--%>
    <%if (((dep.ToUpper() == "ADMIN" || dep.ToUpper() == "IT") && currStation == "Y"))
      { %>
    <div style="background-color: white; padding: 0px 8px; width: 300px;">
        <%-- <asp:checkboxlist id="ChkSyncStat" runat="server" repeatdirection="Horizontal" repeatlayout="Flow"></asp:checkboxlist>--%>
        <ext:CheckboxGroup ID="tblChkGroup" ColumnsNumber="6" runat="server"></ext:CheckboxGroup>
    </div>
    <%} %>
</td>
</tr>
<tr>
    <td colspan="2" align="left" height="10"></td>
</tr>
<tr>
    <td align="left">
        <table border="0" cellpadding="0" cellspacing="1" bgcolor="8db2e3" width="392px">
            <tr>
                <td align="left" background="../../images/bg_line_3.jpg" bgcolor="#FFFFFF" class="font_11bold_1542af"
                    style="padding-left: 5px; height: 20px; line-height: 20px">General Information
                </td>
            </tr>
        </table>
    </td>
    <td width="312" align="left" style="padding-left: 5px">
        <table width="312" border="0" cellpadding="0" cellspacing="1" bgcolor="8db2e3">
            <tr>
                <td align="left" background="../../images/bg_line_3.jpg" bgcolor="#FFFFFF" class="font_11bold_1542af"
                    style="padding-left: 5px; height: 20px; line-height: 20px">Format on AWB / BL
                </td>
            </tr>
        </table>
    </td>
</tr>
<tr>
    <td colspan="2" align="left" height="2"></td>
</tr>
<tr>
    <td height="2"></td>
</tr>
<tr>
    <td align="left" valign="top">
        <table width="310" border="0" cellpadding="0" cellspacing="0" id="baseCompany" class="table_25left_01">
            <tr>
                <td width="61" valign="top" style="padding-left: 8px">
                    <table width="68" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td class="font_11bold">Company<span class="font_red" style="padding-left: 2px">*</span>
                            </td>
                        </tr>
                    </table>
                </td>
                <td colspan="3">
                    <ext:TextField AllowBlank="false" ID="geCompany" runat="server" Cls="text_Courier"
                        TabIndex="9" Width="310" MaxLength="43" EnableKeyEvents="true" Height="17" StyleSpec=" margin-bottom:2px;">
                        <Listeners>
                            <KeyUp Handler="Address(this.id);" />
                            <Blur Handler="ValidSpecialCharacter(this.id);" />
                        </Listeners>
                    </ext:TextField>
                </td>
            </tr>
            <tr>
                <td style="padding-left: 8px; vertical-align: top" class="font_11bold">Address
                </td>
                <td colspan="3">
                    <table cellpadding="0" cellspacing="0">
                        <tr>
                            <td style="padding-bottom: 2px; padding-top: 2px">
                                <ext:TextField ID="geAddress1" runat="server" Cls="text_Courier" TabIndex="10" Width="310"
                                    EnableKeyEvents="true" StyleSpec=" margin-bottom:2px;" Height="17" MaxLength="43">
                                    <Listeners>
                                        <KeyUp Handler="Address(this.id);" />
                                        <Blur Handler="ValidSpecialCharacter(this.id);" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-bottom: 2px">
                                <ext:TextField ID="geAddress2" runat="server" Cls="text_Courier" TabIndex="11" Width="310"
                                    EnableKeyEvents="true" StyleSpec=" margin-bottom:2px" Height="17" MaxLength="43">
                                    <Listeners>
                                        <KeyUp Handler="Address(this.id);" />
                                        <Blur Handler="ValidSpecialCharacter(this.id);" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-bottom: 2px;">
                                <ext:TextField ID="geAddress3" runat="server" Cls="text_Courier" TabIndex="12" Width="310"
                                    EnableKeyEvents="true" StyleSpec=" margin-bottom:2px" Height="17" MaxLength="43">
                                    <Listeners>
                                        <KeyUp Handler="Address(this.id);" />
                                        <Blur Handler="ValidSpecialCharacter(this.id);" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-bottom: 2px">
                                <ext:TextField ID="geAddress4" runat="server" Cls="text_Courier" TabIndex="13" Width="310"
                                    EnableKeyEvents="true" Height="17" MaxLength="43">
                                    <Listeners>
                                        <KeyUp Handler="Address(this.id);" />
                                        <Blur Handler="ValidSpecialCharacter(this.id);" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="padding-left: 8px;">State
                </td>
                <td colspan="2">
                    <table cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                <ext:TextField ID="geState" runat="server" Cls="select_160px" Width="77" TabIndex="13"
                                    EnableKeyEvents="true">
                                    <Listeners>
                                        <KeyUp Handler="Address(this.id);" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                            <td style="width: 60px; text-align: center">ZIP Code
                            </td>
                            <td>
                                <ext:TextField ID="geZIP" runat="server" Cls="select_160px" Width="60" TabIndex="13"
                                    EnableKeyEvents="true">
                                    <Listeners>
                                        <KeyUp Handler="Address(this.id);" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                            <td style="width: 60px; text-align: center">Country
                            </td>
                            <td>
                                <ext:TextField ID="geCountry" Width="55" runat="server" Cls="select_160px" TabIndex="13"
                                    EnableKeyEvents="true">
                                    <Listeners>
                                        <KeyUp Handler="Address(this.id);" />
                                    </Listeners>
                                </ext:TextField>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="padding-left: 8px" class="font_11bold">Contact
                </td>
                <td colspan="3">
                    <ext:TextField ID="geContact" runat="server" Cls="text_Courier" TabIndex="14" Width="310"
                        Height="17" EnableKeyEvents="true">
                        <Listeners>
                            <KeyUp Handler="Address(this.id);" />
                        </Listeners>
                    </ext:TextField>
                </td>
            </tr>
            <tr>
                <td valign="top" style="padding-left: 8px" class="font_11bold">Phone
                </td>
                <td>
                    <ext:TextField ID="gePhone" runat="server" Cls="text_Courier" TabIndex="15" Width="310"
                        Height="17" EnableKeyEvents="true">
                        <Listeners>
                            <KeyUp Handler="Address(this.id);" />
                        </Listeners>
                    </ext:TextField>
                </td>
            </tr>
            <tr>
                <td valign="top" style="padding-left: 8px" class="font_11bold">Fax
                </td>
                <td>
                    <ext:TextField ID="geFax" runat="server" Cls="text_Courier" TabIndex="16" Width="310"
                        Height="17" EnableKeyEvents="true">
                        <Listeners>
                            <KeyUp Handler="Address(this.id);" />
                        </Listeners>
                    </ext:TextField>
                </td>
            </tr>
            <tr>
                <td valign="top" style="padding-left: 8px" class="font_11bold">Mobile
                </td>
                <td colspan="3">
                    <ext:TextField ID="geMobile" runat="server" Cls="text_Courier" TabIndex="17" Width="310"
                        Height="17" EnableKeyEvents="true">
                        <Listeners>
                            <KeyUp Handler="Address(this.id);" />
                        </Listeners>
                    </ext:TextField>
                </td>
            </tr>
            <tr>
                <td valign="top" style="padding-left: 8px;" class="font_11bold">E-Mail
                </td>
                <td colspan="3">
                    <ext:TextField ID="geEmail" runat="server" Cls="text_Courier" TabIndex="18" Width="310"
                        StyleSpec="text-transform:none;" Height="17" EnableKeyEvents="true">
                        <Listeners>
                            <KeyUp Handler="Address(this.id);" />
                        </Listeners>
                    </ext:TextField>
                </td>
            </tr>
        </table>
    </td>
    <td width="309" align="left" valign="top" style="padding-left: 3px">
        <table width="309" border="0" cellpadding="0" cellspacing="0" class="table_25left_01">
            <tr>
                <td align="left" valign="top" style="padding-top: 2px; padding-left: 3px">
                    <%--<textarea name="geAWB" id="geAWB" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; width:273px; height:115px"  disabled="disabled"></textarea>--%>
                    <div id="geAWB" runat="server" name="geAWB" style="line-height: 16px; width: 310px; overflow: hidden; white-space: nowrap; word-break: break-all; height: 124px; font-family: Courier New; font-size: 12px">
                    </div>
                </td>
            </tr>
        </table>
        <table width="280" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td height="2px"></td>
            </tr>
        </table>
        <table width="310" border="0" cellspacing="0" cellpadding="0">
            <%--2014-12-10 Grace--%>
            <%--  <tr id="tr_userfrom" runat="server">
                <td width="100" class="font_11bold" style="padding-left: 5px">
                    <table width="100" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td>
                                Request From
                                <span class="font_red" style="padding-left: 2px">*</span>
                            </td>
                        </tr>
                    </table>
                </td>
                <td>
                    <ext:Store runat="server" ID="storeFromUser">
                        <Reader>
                            <ext:JsonReader>
                                <Fields>
                                    <ext:RecordField Name="value">
                                    </ext:RecordField>
                                    <ext:RecordField Name="text">
                                    </ext:RecordField>
                                </Fields>
                            </ext:JsonReader>
                        </Reader>
                    </ext:Store>
                    <ext:ComboBox runat="server" ID="cmbFromUser" StoreID="storeFromUser" Width="200"
                        Mode="Local" ForceSelection="true" Cls="select_160px" TabIndex="18" ValueField="text"
                        DisplayField="text" ItemSelector="tr.list-item">
                  
                    <template id="Template1" runat="server">
                            <Html>
                            <tpl for=".">
                                                            <tpl if="[xindex] == 1">
                                                                <table class="cbStates-list">
                                                                    <tr>                                
                                                                        <th>USER</th>
                                                                        <th>STAT</th>
                                                                    </tr>
                                                                    </tpl>
                                                                    <tr class="list-item">
                                                                        <td style="padding:3px 0px; width:60%">{text}</td>
                                                                        <td style="padding:3px 0px; width:40%">{value}</td>
                                                                    </tr>
                                                                    <tpl if="[xcount-xindex]==0">
                                                                   </table>
        </tpl> </tpl> </html> </Template> </ext:ComboBox>
    </td>
</tr>
<tr>
    <td width="100" class="font_11bold" style="padding-left: 5px">
        <table width="100" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td>
                    Keyword
                </td>
            </tr>
        </table>
    </td>
    <td>
        <ext:TextField ID="geKeyword" runat="server" Cls="text_Courier" TabIndex="19" Width="200"
            Height="17">
        </ext:TextField>
    </td>
</tr>--%>
            <tr>
                <td class="font_11bold" style="padding-left: 5px; display: none">Group of
                </td>
                <td>
                    <%--<uc1:UserComboBox runat="server" ID="Group" clsClass="select_160px" TabIndex="20"
                                                    Query="option=Companylist" StoreID="StoreCmb5" Width="120" isButton="false" ListWidth="350" />--%>
                </td>
            </tr>
        </table>
        <table>
            <tr>
                <td align="left" style="padding-top: 5px">
                    <table width="308" border="0" cellpadding="0" cellspacing="1" bgcolor="8db2e3">
                        <tr>
                            <td align="left" background="../../images/bg_line_3.jpg" bgcolor="#FFFFFF" class="font_11bold_1542af"
                                style="padding-left: 5px; height: 20px; line-height: 20px">Remark
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <ext:TextArea ID="Remark" runat="server" StyleSpec="width: 300px; height: 370px; position: absolute;
                        background: #ffffff; font-family: Verdana; font-size: 10px; border: 1px solid #b5b8c8;"
                        TabIndex="20">
                    </ext:TextArea>
                </td>
            </tr>
        </table>
    </td>
</tr>
</table> </td> </tr>
<tr>
    <td height="5"></td>
</tr>
<tr>
    <td class="table_25left_01">
        <div id="BILLDisplay" style="display: block;">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="385" valign="top">
                        <table width="385" border="0" cellpadding="0" cellspacing="1" bgcolor="8db2e3">
                            <tr>
                                <td align="left" background="../../images/bg_line_3.jpg" bgcolor="#FFFFFF" class="font_11bold_1542af"
                                    style="padding-left: 5px">
                                    <table width="385" border="0" cellspacing="0" cellpadding="0" style="height: 22px; line-height: 22px">
                                        <tr>
                                            <td>Billing Information
                                            </td>
                                            <td align="right" style="padding-right: 1px">
                                                <span onclick='Copy("bi")' style="cursor: pointer;"><span style="background-image: url(../../../images/btn_4.jpg); width: 40px; height: 19px; display: block; line-height: 19px; padding-right: 10px"
                                                    tabindex="21">Copy</span></span>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td width="303" valign="top" style="padding-left: 5px"></td>
                </tr>
                <tr>
                    <td colspan="2" valign="top" height="2"></td>
                </tr>
                <tr>
                    <td valign="top">
                        <table width="312" border="0" cellpadding="0" cellspacing="0" class="table_25left_01">
                            <tr>
                                <td width="68" valign="top" style="padding-left: 8px">
                                    <table width="68" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td class="font_11bold">Credit Term
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="234" colspan="3">
                                    <ext:TextField ID="biCredit" runat="server" TabIndex="22" Cls="text_Courier" Height="17"
                                        Width="310">
                                    </ext:TextField>
                                </td>
                            </tr>
                            <tr>
                                <td width="68" valign="top" style="padding-left: 8px">
                                    <table width="68" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td class="font_11bold">Payment To
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="234" colspan="3">
                                    <ext:TextField ID="biPaymentto" runat="server" TabIndex="22" Cls="text_Courier" Height="17"
                                        Width="310" MaxLength="43">
                                    </ext:TextField>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" style="padding-left: 8px" class="style1">Company
                                </td>
                                <td class="style2" colspan="3">
                                    <ext:TextField ID="biCompany" runat="server" TabIndex="23" Cls="text_Courier" Height="17"
                                        Width="310">
                                        <Listeners>
                                            <Blur Handler="ValidSpecialCharacter(this.id);" />
                                        </Listeners>
                                    </ext:TextField>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" style="padding-left: 8px" class="font_11bold">Address
                                </td>
                                <td colspan="3">
                                    <table cellpadding="0" cellspacing="0" border="0">
                                        <tr>
                                            <td style="padding-bottom: 4px; padding-top: 2px">
                                                <ext:TextField ID="biAddress1" runat="server" Cls="text_Courier" TabIndex="24" Width="310"
                                                    Height="17" MaxLength="43">
                                                    <Listeners>
                                                        <Blur Handler="ValidSpecialCharacter(this.id);" />
                                                    </Listeners>
                                                </ext:TextField>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding-bottom: 4px">
                                                <ext:TextField ID="biAddress2" runat="server" Cls="text_Courier" TabIndex="25" Width="310"
                                                    Height="17" MaxLength="43">
                                                    <Listeners>
                                                        <Blur Handler="ValidSpecialCharacter(this.id);" />
                                                    </Listeners>
                                                </ext:TextField>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding-bottom: 4px">
                                                <ext:TextField ID="biAddress3" runat="server" Cls="text_Courier" TabIndex="26" Width="310"
                                                    Height="17" MaxLength="43">
                                                    <Listeners>
                                                        <Blur Handler="ValidSpecialCharacter(this.id);" />
                                                    </Listeners>
                                                </ext:TextField>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding-bottom: 2px">
                                                <ext:TextField ID="biAddress4" runat="server" Cls="text_Courier" TabIndex="27" Width="310"
                                                    Height="17" MaxLength="43">
                                                    <Listeners>
                                                        <Blur Handler="ValidSpecialCharacter(this.id);" />
                                                    </Listeners>
                                                </ext:TextField>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-left: 8px">State
                                </td>
                                <td>
                                    <table cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td>
                                                <ext:TextField ID="biState" runat="server" Cls="select_160px" Width="77" TabIndex="27">
                                                </ext:TextField>
                                            </td>
                                            <td style="width: 60px; text-align: center">ZIP Code
                                            </td>
                                            <td>
                                                <ext:TextField ID="biZIP" runat="server" Cls="select_160px" Width="60" TabIndex="27">
                                                </ext:TextField>
                                            </td>
                                            <td style="width: 60px; text-align: center">Country
                                            </td>
                                            <td>
                                                <ext:TextField ID="biCountry" Width="55" runat="server" Cls="select_160px" TabIndex="27">
                                                </ext:TextField>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" style="padding-left: 8px" class="font_11bold">Contact
                                </td>
                                <td colspan="3">
                                    <ext:TextField ID="biContact" runat="server" TabIndex="28" Cls="text_Courier" Height="17"
                                        Width="310">
                                    </ext:TextField>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" style="padding-left: 8px" class="font_11bold">Phone
                                </td>
                                <td>
                                    <ext:TextField ID="biPhone" runat="server" TabIndex="29" Cls="text_Courier" Height="17"
                                        Width="310px">
                                    </ext:TextField>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" style="padding-left: 8px" class="font_11bold">Fax
                                </td>
                                <td>
                                    <ext:TextField ID="biFax" runat="server" TabIndex="30" Cls="text_Courier" Height="17"
                                        Width="310px">
                                    </ext:TextField>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" style="padding-left: 8px" class="font_11bold">E-Mail
                                </td>
                                <td colspan="3">
                                    <ext:TextField ID="biEmail" runat="server" TabIndex="31" Cls="text_Courier" Height="17"
                                        StyleSpec="text-transform:none;" Width="310">
                                    </ext:TextField>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td height="12" valign="top" style="padding-left: 10px; padding-top: 2px;" class="table_25left_01">
                        <%--<textarea name="biRemark" id="biRemark" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; width:274px; height:240px; line-height:15px"></textarea>--%>
                    </td>
                </tr>
            </table>
        </div>
        <div id="AEDisplay" style="display: none;">
            <table>
                <tr>
                    <td height="5" colspan="2" valign="top"></td>
                </tr>
                <tr>
                    <td valign="top">
                        <table width="390" border="0" cellpadding="0" cellspacing="1" bgcolor="8db2e3">
                            <tr>
                                <td align="left" background="../../../images/bg_line_3.jpg" bgcolor="#FFFFFF" class="font_11bold_1542af"
                                    style="padding-left: 5px">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="height: 22px; line-height: 22px">
                                        <tr>
                                            <td>AE
                                            </td>
                                            <td align="right" class="nav_menu_4" style="padding-right: 1px">
                                                <span onclick='Copy("ae")' style="cursor: pointer;"><span style="background-image: url(../../../images/btn_4.jpg); width: 40px; height: 19px; display: block; line-height: 19px; padding-right: 10px"
                                                    tabindex="32">Copy</span></span>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td height="12" valign="top" style="padding-left: 3px">
                        <table width="308" height="24" border="0" cellpadding="0" cellspacing="1" bgcolor="8db2e3">
                            <tr>
                                <td align="left" background="../../images/bg_line_3.jpg" bgcolor="#FFFFFF" class="font_11bold_1542af"
                                    style="padding-left: 5px">Format on AWB / BL
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td height="5" colspan="2" valign="top"></td>
                </tr>
                <tr>
                    <td valign="top">
                        <table width="312" border="0" cellpadding="0" cellspacing="0" class="table_25left_01">
                            <tr>
                                <td valign="top" style="padding-left: 6px">
                                    <table width="68" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td class="font_11bold">Company
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="234" colspan="3">
                                    <ext:TextField ID="aeCompany" runat="server" TabIndex="33" Cls="text_Courier" Height="17"
                                        Width="310">
                                    </ext:TextField>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" style="padding-left: 6px" class="font_11bold">Address
                                </td>
                                <td style="padding-top: 2px; padding-bottom: 2px" colspan="3">
                                    <ext:TextField ID="aeAddress1" runat="server" Cls="text_Courier" TabIndex="34" Width="310"
                                        StyleSpec=" margin-bottom:5px" Height="17" MaxLength="43">
                                    </ext:TextField>
                                    <ext:TextField ID="aeAddress2" runat="server" Cls="text_Courier" TabIndex="34" Width="310"
                                        StyleSpec=" margin-bottom:5px" Height="17" MaxLength="43">
                                    </ext:TextField>
                                    <ext:TextField ID="aeAddress3" runat="server" Cls="text_Courier" TabIndex="34" Width="310"
                                        StyleSpec=" margin-bottom:5px" Height="17" MaxLength="43">
                                    </ext:TextField>
                                    <ext:TextField ID="aeAddress4" runat="server" Cls="text_Courier" TabIndex="34" Width="310"
                                        Height="17" MaxLength="43">
                                    </ext:TextField>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" style="padding-left: 6px" class="font_11bold">Contact
                                </td>
                                <td colspan="3">
                                    <ext:TextField ID="aeContact" runat="server" Cls="text_Courier" Height="17" Width="310"
                                        TabIndex="35">
                                    </ext:TextField>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" style="padding-left: 6px" class="font_11bold">Phone
                                </td>
                                <td>
                                    <ext:TextField ID="aePhone" runat="server" Cls="text_Courier" Height="17" Width="310"
                                        TabIndex="36">
                                    </ext:TextField>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" style="padding-left: 6px" class="font_11bold">Fax
                                </td>
                                <td>
                                    <ext:TextField ID="aeFax" runat="server" Cls="text_Courier" Height="17" Width="310"
                                        TabIndex="37">
                                    </ext:TextField>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" style="padding-left: 6px" class="font_11bold">E-Mail
                                </td>
                                <td colspan="3">
                                    <ext:TextField ID="aeEmail" runat="server" Cls="text_Courier" Height="17" Width="310"
                                        TabIndex="38">
                                    </ext:TextField>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td height="12" valign="top" style="padding-left: 5px; padding-top: 2px" class="table_25left_01">
                        <%--<textarea name="aeAWB"  id="aeAWB" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; width:274px; height:115px; line-height:15px" disabled="disabled"></textarea>--%>
                        <div id="aeAWB" runat="server" name="aeAWB" style="font-family: Arial, Helvetica, sans-serif; font-size: 11px; width: 274px; height: 115px; line-height: 15px">
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <div id="AIDisplay" style="display: none;">
            <table>
                <tr>
                    <td height="5" colspan="2" valign="top"></td>
                </tr>
                <tr>
                    <td valign="top">
                        <table width="390" border="0" cellpadding="0" cellspacing="1" bgcolor="8db2e3">
                            <tr>
                                <td align="left" background="../../images/bg_line_3.jpg" bgcolor="#FFFFFF" class="font_11bold_1542af"
                                    style="padding-left: 5px; line-height: 22px; height: 22px">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="240">AI
                                            </td>
                                            <td align="right" class="nav_menu_4" style="padding-right: 1px">
                                                <span onclick='Copy("ai")' style="cursor: pointer;"><span style="background-image: url(../../../images/btn_4.jpg); width: 40px; height: 19px; display: block; line-height: 19px; padding-right: 10px"
                                                    tabindex="39">Copy</span></span>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td height="12" valign="top" style="padding-left: 8px">&nbsp;
                    </td>
                </tr>
                <tr>
                    <td height="5" colspan="2" valign="top"></td>
                </tr>
                <tr>
                    <td valign="top">
                        <table width="312" border="0" cellpadding="0" cellspacing="0" class="table_25left_01">
                            <tr>
                                <td valign="top" style="padding-left: 6px">
                                    <table width="68" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td class="font_11bold">Company
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="234" colspan="3">
                                    <ext:TextField ID="aiCompany" runat="server" Cls="text_Courier" Width="310" Height="17"
                                        TabIndex="40">
                                    </ext:TextField>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" style="padding-left: 6px" class="font_11bold">Address
                                </td>
                                <td style="padding-bottom: 2px; padding-top: 2px" colspan="3">
                                    <ext:TextField ID="aiAddress1" runat="server" Cls="text_Courier" TabIndex="41" Width="310"
                                        StyleSpec=" margin-bottom:5px" Height="17" MaxLength="43">
                                    </ext:TextField>
                                    <ext:TextField ID="aiAddress2" runat="server" Cls="text_Courier" TabIndex="41" Width="310"
                                        StyleSpec=" margin-bottom:5px" Height="17" MaxLength="43">
                                    </ext:TextField>
                                    <ext:TextField ID="aiAddress3" runat="server" Cls="text_Courier" TabIndex="41" Width="310"
                                        StyleSpec=" margin-bottom:5px" Height="17" MaxLength="43">
                                    </ext:TextField>
                                    <ext:TextField ID="aiAddress4" runat="server" Cls="text_Courier" TabIndex="41" Width="310"
                                        Height="17" MaxLength="43">
                                    </ext:TextField>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" style="padding-left: 6px" class="font_11bold">Contact
                                </td>
                                <td colspan="3">
                                    <ext:TextField ID="aiContact" runat="server" Cls="text_Courier" Width="310" Height="17"
                                        TabIndex="42">
                                    </ext:TextField>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" style="padding-left: 6px" class="font_11bold">Phone
                                </td>
                                <td>
                                    <ext:TextField ID="aiPhone" runat="server" Cls="text_Courier" Width="310" Height="17"
                                        TabIndex="43">
                                    </ext:TextField>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" style="padding-left: 16px; padding-right: 13px" class="font_11bold">Fax
                                </td>
                                <td>
                                    <ext:TextField ID="aiFax" runat="server" Cls="text_Courier" Width="310" Height="17"
                                        TabIndex="44">
                                    </ext:TextField>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" style="padding-left: 6px" class="font_11bold">E-Mail
                                </td>
                                <td colspan="3">
                                    <ext:TextField ID="aiEmail" runat="server" Cls="text_Courier" Width="310" Height="17"
                                        TabIndex="45">
                                    </ext:TextField>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td height="12" valign="top" style="padding-left: 8px">&nbsp;
                    </td>
                </tr>
            </table>
        </div>
        <div id="OEDisplay" style="display: none;">
            <table>
                <tr>
                    <td height="5" colspan="2" valign="top"></td>
                </tr>
                <tr>
                    <td valign="top">
                        <table width="390" height="24" border="0" cellpadding="0" cellspacing="1" bgcolor="8db2e3">
                            <tr>
                                <td align="left" background="../../images/bg_line_3.jpg" bgcolor="#FFFFFF" class="font_11bold_1542af"
                                    style="padding-left: 5px">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="240">OE
                                            </td>
                                            <td align="right" class="nav_menu_4" style="padding-right: 1px">
                                                <span onclick='Copy("oe")' style="cursor: pointer;"><span style="background-image: url(../../../images/btn_4.jpg); width: 40px; height: 19px; display: block; line-height: 19px; padding-right: 10px"
                                                    tabindex="46">Copy</span></span>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td height="12" valign="top" style="padding-left: 3px">
                        <table width="308" height="24" border="0" cellpadding="0" cellspacing="1" bgcolor="8db2e3">
                            <tr>
                                <td align="left" background="../../images/bg_line_3.jpg" bgcolor="#FFFFFF" class="font_11bold_1542af"
                                    style="padding-left: 5px">Format on AWB / BL
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td height="5" colspan="2" valign="top"></td>
                </tr>
                <tr>
                    <td valign="top">
                        <table width="312" border="0" cellpadding="0" cellspacing="0" class="table_25left_01">
                            <tr>
                                <td valign="top" style="padding-left: 6px">
                                    <table width="68" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td class="font_11bold">Company
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="234" colspan="3">
                                    <ext:TextField ID="oeCompany" runat="server" Cls="text_Courier" Width="310" Height="17"
                                        TabIndex="47">
                                    </ext:TextField>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" style="padding-left: 6px" class="font_11bold">Address
                                </td>
                                <td style="padding-bottom: 2px; padding-top: 2px" colspan="3">
                                    <ext:TextField ID="oeAddress1" runat="server" Cls="text_Courier" TabIndex="48" Width="310"
                                        StyleSpec=" margin-bottom:5px" Height="17" MaxLength="43">
                                    </ext:TextField>
                                    <ext:TextField ID="oeAddress2" runat="server" Cls="text_Courier" TabIndex="48" Width="310"
                                        StyleSpec=" margin-bottom:5px" Height="17" MaxLength="43">
                                    </ext:TextField>
                                    <ext:TextField ID="oeAddress3" runat="server" Cls="text_Courier" TabIndex="48" Width="310"
                                        StyleSpec=" margin-bottom:5px" Height="17" MaxLength="43">
                                    </ext:TextField>
                                    <ext:TextField ID="oeAddress4" runat="server" Cls="text_Courier" TabIndex="48" Width="310"
                                        Height="17" MaxLength="43">
                                    </ext:TextField>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" style="padding-left: 6px" class="font_11bold">Contact
                                </td>
                                <td colspan="3">
                                    <ext:TextField ID="oeContact" runat="server" Cls="text_Courier" Width="310" Height="17"
                                        TabIndex="49">
                                    </ext:TextField>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" style="padding-left: 6px" class="font_11bold">Phone
                                </td>
                                <td>
                                    <ext:TextField ID="oePhone" runat="server" Cls="text_Courier" Width="310" Height="17"
                                        TabIndex="50">
                                    </ext:TextField>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" style="padding-left: 6px" class="font_11bold">Fax
                                </td>
                                <td>
                                    <ext:TextField ID="oeFax" runat="server" Cls="text_Courier" Width="310" Height="17"
                                        TabIndex="51">
                                    </ext:TextField>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" style="padding-left: 6px" class="font_11bold">E-Mail
                                </td>
                                <td colspan="3">
                                    <ext:TextField ID="oeEmail" runat="server" Cls="text_Courier" Width="310" Height="17"
                                        TabIndex="52">
                                    </ext:TextField>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td height="12" valign="top" style="padding-left: 5px; padding-top: 2px;" class="table_25left_01">
                        <%--<textarea name="oeAWB" id="oeAWB" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; width:274px; height:115px; line-height:15px" disabled="disabled"></textarea>--%>
                        <div id="oeAWB" runat="server" name="oeAWB" style="font-family: Arial, Helvetica, sans-serif; font-size: 11px; width: 274px; height: 115px; line-height: 15px">
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <div id="OIDisplay" style="display: none;">
            <table>
                <tr>
                    <td height="5" colspan="2" valign="top"></td>
                </tr>
                <tr>
                    <td valign="top">
                        <table width="390" border="0" cellpadding="0" cellspacing="1" bgcolor="8db2e3">
                            <tr>
                                <td align="left" background="../../images/bg_line_3.jpg" bgcolor="#FFFFFF" class="font_11bold_1542af"
                                    style="padding-left: 5px">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="height: 22px; line-height: 22px">
                                        <tr>
                                            <td width="240">OI
                                            </td>
                                            <td align="right" class="nav_menu_4" style="padding-right: 1px">
                                                <span onclick='Copy("oi")' style="cursor: pointer;"><span style="background-image: url(../../../images/btn_4.jpg); width: 40px; height: 19px; display: block; line-height: 19px; padding-right: 10px"
                                                    tabindex="53">Copy</span></span>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td height="12" valign="top" style="padding-left: 6px">&nbsp;
                    </td>
                </tr>
                <tr>
                    <td height="5" colspan="2" valign="top"></td>
                </tr>
                <tr>
                    <td valign="top">
                        <table width="312" border="0" cellpadding="0" cellspacing="0" class="table_25left_01">
                            <tr>
                                <td valign="top" style="padding-left: 6px">
                                    <table width="68" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td class="font_11bold">Company
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="234" colspan="3">
                                    <ext:TextField ID="oiCompany" runat="server" Cls="text_Courier" Width="310" Height="17"
                                        TabIndex="54">
                                    </ext:TextField>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" style="padding-left: 6px" class="font_11bold">Address
                                </td>
                                <td style="padding-bottom: 2px; padding-top: 2px" colspan="3">
                                    <ext:TextField ID="oiAddress1" runat="server" Cls="text_Courier" TabIndex="55" Width="310"
                                        StyleSpec=" margin-bottom:5px" Height="17" MaxLength="43">
                                    </ext:TextField>
                                    <ext:TextField ID="oiAddress2" runat="server" Cls="text_Courier" TabIndex="55" Width="310"
                                        StyleSpec=" margin-bottom:5px" Height="17" MaxLength="43">
                                    </ext:TextField>
                                    <ext:TextField ID="oiAddress3" runat="server" Cls="text_Courier" TabIndex="55" Width="310"
                                        StyleSpec=" margin-bottom:5px" Height="17" MaxLength="43">
                                    </ext:TextField>
                                    <ext:TextField ID="oiAddress4" runat="server" Cls="text_Courier" TabIndex="55" Width="310"
                                        Height="17" MaxLength="43">
                                    </ext:TextField>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" style="padding-left: 6px" class="font_11bold">Contact
                                </td>
                                <td colspan="3">
                                    <ext:TextField ID="oiContact" runat="server" Cls="text_Courier" Width="310" Height="17"
                                        TabIndex="56">
                                    </ext:TextField>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" style="padding-left: 6px" class="font_11bold">Phone
                                </td>
                                <td>
                                    <ext:TextField ID="oiPhone" runat="server" Cls="text_Courier" Width="310" Height="17"
                                        TabIndex="57">
                                    </ext:TextField>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" style="padding-left: 6px" class="font_11bold">Fax
                                </td>
                                <td>
                                    <ext:TextField ID="oiFax" runat="server" Cls="text_Courier" Width="310" Height="17"
                                        TabIndex="58">
                                    </ext:TextField>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" style="padding-left: 6px" class="font_11bold">E-Mail
                                </td>
                                <td colspan="3">
                                    <ext:TextField ID="oiEmail" runat="server" Cls="text_Courier" Width="310" Height="17"
                                        TabIndex="59">
                                    </ext:TextField>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td height="12" valign="top" style="padding-left: 8px">&nbsp;
                    </td>
                </tr>
            </table>
        </div>
        <div id="div_china" style="display: none">
            <table>
                <tr>
                    <td height="5" colspan="2" valign="top"></td>
                </tr>
                <tr>
                    <td valign="top">
                        <table width="390" border="0" cellpadding="0" cellspacing="1" bgcolor="8db2e3">
                            <tr>
                                <td align="left" background="../../images/bg_line_3.jpg" bgcolor="#FFFFFF" class="font_11bold_1542af"
                                    style="padding-left: 5px">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="height: 22px; line-height: 22px">
                                        <tr>
                                            <td width="240">Local Information
                                            </td>
                                            <td align="right" class="nav_menu_4" style="padding-right: 1px">
                                                <span onclick='Copy("txtC")' style="cursor: pointer;"><span style="background-image: url(../../../images/btn_4.jpg); width: 40px; height: 19px; display: block; line-height: 19px; padding-right: 10px">Copy</span></span>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td height="12" valign="top" style="padding-left: 6px">&nbsp;
                    </td>
                </tr>
                <tr>
                    <td height="5" colspan="2" valign="top"></td>
                </tr>
                <tr>
                    <td valign="top">
                        <table width="312" border="0" cellpadding="0" cellspacing="0" class="table_25left_01">
                            <tr>
                                <td valign="top" style="padding-left: 6px">
                                    <table width="68" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td class="font_11bold">Company
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="234" colspan="3">
                                    <ext:TextField ID="txtCCompany" runat="server" Cls="text_Courier" Width="310" Height="17"
                                        TabIndex="54" EnableKeyEvents="true">
                                        <Listeners>
                                            <KeyUp Handler="Address1();" />
                                            <Blur Handler="ValidSpecialCharacter(this.id);" />
                                        </Listeners>
                                    </ext:TextField>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" style="padding-left: 6px" class="font_11bold">Address
                                </td>
                                <td style="padding-bottom: 2px; padding-top: 2px" colspan="3">
                                    <ext:TextField ID="txtCAddress1" runat="server" Cls="text_Courier" TabIndex="55"
                                        Width="310" StyleSpec=" margin-bottom:5px" Height="17" MaxLength="43" EnableKeyEvents="true">
                                        <Listeners>
                                            <KeyUp Handler="Address1();" />
                                            <Blur Handler="ValidSpecialCharacter(this.id);" />
                                        </Listeners>
                                    </ext:TextField>
                                    <br />
                                    <ext:TextField ID="txtCAddress2" runat="server" Cls="text_Courier" TabIndex="55"
                                        Width="310" StyleSpec=" margin-bottom:5px" Height="17" MaxLength="43" EnableKeyEvents="true">
                                        <Listeners>
                                            <KeyUp Handler="Address1();" />
                                            <Blur Handler="ValidSpecialCharacter(this.id);" />
                                        </Listeners>
                                    </ext:TextField>
                                    <br />
                                    <ext:TextField ID="txtCAddress3" runat="server" Cls="text_Courier" TabIndex="55"
                                        Width="310" StyleSpec=" margin-bottom:5px" Height="17" MaxLength="43" EnableKeyEvents="true">
                                        <Listeners>
                                            <KeyUp Handler="Address1();" />
                                            <Blur Handler="ValidSpecialCharacter(this.id);" />
                                        </Listeners>
                                    </ext:TextField>
                                    <br />
                                    <ext:TextField ID="txtCAddress4" runat="server" Cls="text_Courier" TabIndex="55"
                                        Width="310" Height="17" MaxLength="43" EnableKeyEvents="true">
                                        <Listeners>
                                            <KeyUp Handler="Address1();" />
                                            <Blur Handler="ValidSpecialCharacter(this.id);" />
                                        </Listeners>
                                    </ext:TextField>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-left: 8px;">State
                                </td>
                                <td>
                                    <table cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td>
                                                <ext:TextField ID="txtCState" runat="server" Cls="select_160px" Width="77" TabIndex="55">
                                                </ext:TextField>
                                            </td>
                                            <td style="width: 60px; text-align: center">ZIP Code
                                            </td>
                                            <td>
                                                <ext:TextField ID="txtCZIP" runat="server" Cls="select_160px" Width="60" TabIndex="55">
                                                </ext:TextField>
                                            </td>
                                            <td style="width: 60px; text-align: center">Country
                                            </td>
                                            <td>
                                                <ext:TextField ID="txtCCountry" Width="55" runat="server" Cls="select_160px" TabIndex="55">
                                                </ext:TextField>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" style="padding-left: 6px" class="font_11bold">Contact
                                </td>
                                <td colspan="3">
                                    <ext:TextField ID="txtCContact" runat="server" Cls="text_Courier" Width="310" Height="17"
                                        TabIndex="56">
                                    </ext:TextField>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" style="padding-left: 6px" class="font_11bold">Phone
                                </td>
                                <td>
                                    <ext:TextField ID="txtCPhone" runat="server" Cls="text_Courier" Width="310" Height="17"
                                        TabIndex="57">
                                    </ext:TextField>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" style="padding-left: 6px" class="font_11bold">Fax
                                </td>
                                <td>
                                    <ext:TextField ID="txtCFax" runat="server" Cls="text_Courier" Width="310" Height="17"
                                        TabIndex="58">
                                    </ext:TextField>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" style="padding-left: 6px" class="font_11bold">E-Mail
                                </td>
                                <td colspan="3">
                                    <ext:TextField ID="txtCEmail" runat="server" Cls="text_Courier" Width="310" Height="17"
                                        StyleSpec="text-transform:none;" TabIndex="59">
                                    </ext:TextField>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td height="12" valign="top" style="padding-left: 8px">
                        <div id="cngeAWB" runat="server" name="geAWB" style="line-height: 22px; padding-top: 3px; width: 100%; height: 80px; font-family: 宋体; font-size: 12px">
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </td>
</tr>
</table> </div> </div>
<ext:Container runat="server" ID="div_bottom">
</ext:Container>
</form> </body> </html> 